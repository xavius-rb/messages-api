# frozen_string_literal: true

require_relative "api/version"
require_relative "api/configuration"
require_relative "api/factory"
require_relative "api/providers/base"
require_relative "api/providers/message_media"
# require_relative "api/providers/twilio" # Uncomment if Twilio provider is implemented

module Messages
  module Api
    class Error < StandardError
      attr_reader :response_body, :status_code

      def initialize(message = nil, response_body = nil, status_code = nil)
        @response_body = response_body
        @status_code = status_code
        super(message)
      end
    end

    class ClientError < Error; end
    class ServerError < Error; end
    class ConfigurationError < Error; end
    class AuthenticationError < Error; end

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
