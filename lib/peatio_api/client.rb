require 'active_support/core_ext'
require 'active_support/hash_with_indifferent_access'
require 'json'
require 'net/http'
require_relative 'client/version'

module PeatioAPI
  class Client

    def initialize(options={})
      options.symbolize_keys!
      setup_auth_keys options
      @endpoint = options[:endpoint] || 'https://peatio.com'
    end

    def get(path, params={})
      uri = URI("#{@endpoint}#{path}")
      uri.query = URI.encode_www_form(params) if params.present?
      response = Net::HTTP.get_response(uri)

      if response.code == '200'
        JSON.parse response.body
      else
        raise "Request failed: #{response.body}"
      end
    end

    def post(path, params={})
    end

    private

    def setup_auth_keys(options)
      if options[:access_key] && options[:secret_key]
        @access_key = options[:access_key]
        @secret_key = options[:secret_key]
      else
        raise ArgumentError, 'Missing access key and/or secret key'
      end
    end

  end
end
