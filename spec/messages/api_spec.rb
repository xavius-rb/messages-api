# frozen_string_literal: true

RSpec.describe Messages::Api do
  it "has a version number" do
    expect(Messages::Api::VERSION).not_to be nil
  end
end
