# frozen_string_literal: true

require_relative "api/version"
require_relative "api/configuration"
require_relative "api/factory"
require_relative "api/providers/base"
require_relative "api/providers/message_media"
# require_relative "api/providers/twilio" # Uncomment if Twilio provider is implemented

module Messages
  module Api
    class Error < StandardError; end

    def self.configure
      config = Configuration.new
      yield(config) if block_given?
      config
    end

    def self.create_client(config = nil)
      if config.nil?
        # Allow for a global configuration
        config = configure
        yield(config) if block_given?
      end

      Factory.create(config)
    end
  end
end
