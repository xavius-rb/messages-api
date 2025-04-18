# frozen_string_literal: true

module Messages
  module Api
    class Configuration
      attr_accessor :api_key, :api_secret, :base_uri, :provider

      def initialize
        @provider = :message_media # Default provider
      end

      def validate!
        raise ArgumentError, "API key is required" if api_key.nil? || api_key.empty?
        raise ArgumentError, "API secret is required" if api_secret.nil? || api_secret.empty?
        raise ArgumentError, "Base URI is required" if base_uri.nil? || base_uri.empty?
      end
    end
  end
end
