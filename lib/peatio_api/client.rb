require 'active_support/hash_with_indifferent_access'
require_relative 'client/version'

module PeatioAPI
  class Client

    def initialize(options={})
      options.symbolize_keys!
      setup_auth_keys options
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
