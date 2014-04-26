require 'active_support'
require 'active_support/hash_with_indifferent_access'

class PeatioClient

  def initialize(options={})
    options.symbolize_keys!
    setup_auth_keys options
  end

  private

  def setup_auth_keys(options)
    if options[:access_key] && options[:secret_key]
    elsif keys = get_peatiorc
    else
      raise ArgumentError, 'Missing access key and/or secret key'
    end
  end

  def get_peatiorc
    if File.exist? File.join(ENV['HOME'], '.peatiorc')
    end
  end

end
