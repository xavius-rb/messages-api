# frozen_string_literal: true

require "faraday"
require "json"
require "base64"

module Messages
  module Api
    module Providers
      class Base
        attr_reader :config, :connection

        def initialize(config)
          @config = config
          @config.validate!
          initialize_connection
        end

        def send_message(message)
          raise NotImplementedError, "Subclasses must implement #send_message"
        end

        def send_messages(messages)
          raise NotImplementedError, "Subclasses must implement #send_messages"
        end

        private

        def initialize_connection
          @connection = Faraday.new(url: config.base_uri) do |faraday|
            faraday.request :json
            faraday.response :json
            faraday.adapter Faraday.default_adapter
            faraday.headers["Authorization"] = "Basic #{auth_token}"
          end
        end

        def handle_response(response)
          case response.status
          when 200..299
            response.body
          when 400..499
            handle_client_error(response)
          when 500..599
            handle_server_error(response)
          else
            raise Error, "Unexpected response status: #{response.status}"
          end
        end

        def handle_client_error(response)
          raise ClientError.new(
            "Client error: #{response.status}",
            response.body,
            response.status
          )
        end

        def handle_server_error(response)
          raise ServerError.new(
            "Server error: #{response.status}",
            response.body,
            response.status
          )
        end
      end
    end
  end
end
