# frozen_string_literal: true

module Messages
  module Api
    class Configuration
      attr_accessor :api_key, :api_secret, :base_uri, :provider

      def initialize
        @provider = :message_media # Default provider
      end

      def validate!
        raise Messages::Api::ConfigurationError, "API key is required" if api_key.nil? || api_key.empty?
        raise Messages::Api::ConfigurationError, "API secret is required" if api_secret.nil? || api_secret.empty?
        raise Messages::Api::ConfigurationError, "Base URI is required" if base_uri.nil? || base_uri.empty?
      end
    end
  end
end
