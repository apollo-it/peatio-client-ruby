require 'json'
require 'net/http'
require_relative 'client/version'

module PeatioAPI
  class Client

    attr :auth

    def initialize(options={})
      options.symbolize_keys!
      setup_auth_keys options
      @endpoint = options[:endpoint] || 'https://peatio.com'
    end

    def get(path, params={})
      uri = URI("#{@endpoint}#{path}")

      # sign on all requests, even those to public API
      signed_params = @auth.signed_params 'GET', path, params
      uri.query = URI.encode_www_form signed_params

      parse Net::HTTP.get_response(uri)
    end

    def post(path, params={})
      uri = URI("#{@endpoint}#{path}")
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true if @endpoint.start_with?('https://')
      http.start do |http|
        params = @auth.signed_params 'POST', path, params
        parse http.request_post(path, params.to_query)
      end
    end

    private

    def parse(response)
      JSON.parse response.body
    end

    def setup_auth_keys(options)
      if options[:access_key] && options[:secret_key]
        @access_key = options[:access_key]
        @secret_key = options[:secret_key]
        @auth       = Auth.new @access_key, @secret_key
      else
        raise ArgumentError, 'Missing access key and/or secret key'
      end
    end

  end
end
