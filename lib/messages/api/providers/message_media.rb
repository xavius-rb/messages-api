# frozen_string_literal: true

module Messages
  module Api
    module Providers
      class MessageMedia < Base
        def send_message(message)
          send_messages([ message ])
        end

        def send_messages(messages)
          payload = {
            messages: messages.map { |message| message_to_payload(message) }
          }

          response = connection.post("/v1/messages", payload)
          handle_response(response)
        end

        private

        def auth_token
          Base64.strict_encode64("#{config.api_key}:#{config.api_secret}")
        end

        def message_to_payload(message)
          payload = {
            content: message.content,
            destination_number: message.destination_number
          }

          # Only add optional parameters if they're present
          payload[:source_number] = message.source_number if message.source_number
          payload[:callback_url] = message.callback_url if message.callback_url
          payload[:delivery_report] = message.delivery_report unless message.delivery_report.nil?
          payload[:format] = message.format.to_s if message.format
          payload[:source_number_type] = message.source_number_type.to_s.upcase if message.source_number_type
          payload[:media] = message.media if message.media
          payload[:subject] = message.subject if message.subject
          payload[:scheduled] = message.scheduled if message.scheduled
          payload[:message_expiry_timestamp] = message.message_expiry_timestamp if message.message_expiry_timestamp
          payload[:metadata] = message.metadata if message.metadata

          payload
        end
      end
    end
  end
end
