require 'json'
require 'eventmachine'
require 'websocket-eventmachine-client'

module PeatioAPI
  class StreamingClient < Client

    def initialize(options={})
      super
      @endpoint = options[:endpoint] || 'wss://peatio.com:8080'
      @logger   = options[:logger] || Logger.new(STDOUT)
    end

    def run(&callback)
      EM.run do
        ws = WebSocket::EventMachine::Client.connect(uri: @endpoint)

        ws.onopen do
          @logger.info "Connected."
        end

        ws.onmessage do |payload, type|
          msg = JSON.parse(payload)

          key = msg.keys.first
          data = msg[key]
          case key
          when 'challenge'
            ws.send JSON.dump(@auth.signed_challenge(data))
          else
            begin
              callback.call msg
            rescue
              @logger.error "Failed to process message: #{payload}"
              @logger.error $!
            end
          end
        end

        ws.onclose do
          @logger.info "Closed."
          EM.stop
        end

      end

    end

  end
end
