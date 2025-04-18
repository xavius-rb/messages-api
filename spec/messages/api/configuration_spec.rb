# frozen_string_literal: true

require "spec_helper"
require "messages/api/configuration"

RSpec.describe Messages::Api::Configuration do
  let(:config) { described_class.new }

  describe "#initialize" do
    it "sets default provider to message_media" do
      expect(config.provider).to eq(:message_media)
    end

    it "initializes other attributes as nil" do
      expect(config.api_key).to be_nil
      expect(config.api_secret).to be_nil
      expect(config.base_uri).to be_nil
    end
  end

  describe "attribute accessors" do
    it "allows setting and getting api_key" do
      config.api_key = "test_key"
      expect(config.api_key).to eq("test_key")
    end

    it "allows setting and getting api_secret" do
      config.api_secret = "test_secret"
      expect(config.api_secret).to eq("test_secret")
    end

    it "allows setting and getting base_uri" do
      config.base_uri = "https://api.example.com"
      expect(config.base_uri).to eq("https://api.example.com")
    end

    it "allows setting and getting provider" do
      config.provider = :another_provider
      expect(config.provider).to eq(:another_provider)
    end
  end

  describe "#validate!" do
    context "when required fields are missing" do
      it "raises ConfigurationError when api_key is missing" do
        config.api_secret = "secret"
        config.base_uri = "uri"
        expect { config.validate! }.to raise_error(Messages::Api::ConfigurationError, "API key is required")
      end

      it "raises ConfigurationError when api_secret is missing" do
        config.api_key = "key"
        config.base_uri = "uri"
        expect { config.validate! }.to raise_error(Messages::Api::ConfigurationError, "API secret is required")
      end

      it "raises ConfigurationError when base_uri is missing" do
        config.api_key = "key"
        config.api_secret = "secret"
        expect { config.validate! }.to raise_error(Messages::Api::ConfigurationError, "Base URI is required")
      end
    end

    context "when all required fields are present" do
      it "does not raise an error" do
        config.api_key = "key"
        config.api_secret = "secret"
        config.base_uri = "uri"
        expect { config.validate! }.not_to raise_error
      end
    end
  end
end
