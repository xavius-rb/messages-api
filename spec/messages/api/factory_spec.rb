# frozen_string_literal: true

require "spec_helper"
require "messages/api/factory"
require "messages/api/configuration"

RSpec.describe Messages::Api::Factory do
  let(:config) do
    config = Messages::Api::Configuration.new
    config.api_key = "test_key"
    config.api_secret = "test_secret"
    config.base_uri = "https://api.example.com"
    config
  end

  describe ".create" do
    context "when provider is message_media" do
      before do
        config.provider = :message_media
      end

      it "returns a MessageMedia provider instance" do
        # We need to stub the Providers::MessageMedia class
        message_media_provider = double("MessageMedia Provider")

        # Create a proper stub class with an initializer that accepts config
        message_media_class = Class.new do
          def initialize(config)
            # initialize with config
          end
        end

        stub_const("Messages::Api::Providers::MessageMedia", message_media_class)
        allow(Messages::Api::Providers::MessageMedia).to receive(:new).with(config).and_return(message_media_provider)

        provider = described_class.create(config)
        expect(provider).to eq(message_media_provider)
      end
    end

    context "when provider is unsupported" do
      before do
        config.provider = :unsupported_provider
      end

      it "raises an ArgumentError" do
        expect { described_class.create(config) }.to raise_error(
          Messages::Api::ConfigurationError,
          "Unsupported provider: unsupported_provider. Supported providers are: message_media, twilio"
        )
      end
    end

    context "when config is invalid" do
      let(:invalid_config) { Messages::Api::Configuration.new }

      it "raises an error from validation" do
        expect(invalid_config).to receive(:validate!).and_raise(ArgumentError, "API key is required")
        expect { described_class.create(invalid_config) }.to raise_error(ArgumentError, "API key is required")
      end
    end

    context "when provider is twilio" do
      before do
        config.provider = :twilio
      end

      it "is not yet implemented" do
        # Currently commented out in the implementation
        # We can either test the current behavior (which would raise an error)
        # or skip this test until implemented
        pending "Twilio provider not yet implemented"
        expect { described_class.create(config) }.to raise_error(NoMethodError)
      end
    end
  end
end
