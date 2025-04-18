# frozen_string_literal: true

module Messages
  module Api
    class Factory
      def self.create(config)
        config.validate!

        case config.provider
        when :message_media
          Providers::MessageMedia.new(config)
        when :twilio
          # Providers::Twilio.new(config)
        else
          raise ArgumentError, "Unsupported provider: #{config.provider}"
        end
      end
    end
  end
end
