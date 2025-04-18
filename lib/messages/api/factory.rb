# frozen_string_literal: true

module Messages
  module Api
    class Factory
      PROVIDERS = %i[message_media twilio].freeze
      # Creates a provider instance based on the configuration.
      # @param config [Configuration] The configuration object.
      # @return [Object] The provider instance.
      # @raise [ConfigurationError] If the configuration is invalid.
      def self.create(config)
        config.validate!

        case config.provider
        when :message_media
          Providers::MessageMedia.new(config)
        when :twilio
          # Providers::Twilio.new(config)
        else
          raise ConfigurationError,
                "Unsupported provider: #{config.provider}. Supported providers are: #{PROVIDERS.join(", ")}"
        end
      end
    end
  end
end
