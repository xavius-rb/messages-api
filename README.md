# Messages::Api
[![Ruby](https://github.com/xavius-rb/messages-api/actions/workflows/main.yml/badge.svg)](https://github.com/xavius-rb/messages-api/actions/workflows/main.yml)

A Ruby gem that provides a unified API for sending SMS and other messages through various providers. Currently supports MessageMedia with planned Twilio integration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'messages-api'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install messages-api
```

## Usage

### Basic Configuration

```ruby
Messages::Api.configure do |config|
  config.api_key = "your_api_key"
  config.api_secret = "your_api_secret"
  config.base_uri = "https://api.messagemedia.com"
  config.provider = :message_media # Default provider
end
```

### Sending a Single Message

```ruby

message = OpenStruct.new(
  content: "Hello from Messages::Api!",
  destination_number: "+61411111111",
  source_number: "+61422222222", # Optional
  callback_url: "https://your-callback-url.com", # Optional
  delivery_report: true, # Optional
  format: :sms # Optional
)
client = Messages::Api.create_client
response = client.send_message(message)
```

### Sending Multiple Messages

```ruby
messages = [
  OpenStruct.new(
    content: "Message 1",
    destination_number: "+61411111111"
  ),
  OpenStruct.new(
    content: "Message 2",
    destination_number: "+61422222222"
  )
]

response = client.send_messages(messages)
```

## Supported Providers

- MessageMedia (Default)
- Twilio (Coming soon)

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Using the Dev Container

This project includes a development container configuration for Visual Studio Code and GitHub Codespaces, which provides a consistent development environment with:

1. Ruby and development dependencies pre-installed
2. Docker CLI for container management
3. GitHub CLI for repository operations

To use the dev container:

- **VS Code**: Install the "Remote - Containers" extension and use the "Remote-Containers: Open Folder in Container" command
- **GitHub Codespaces**: Open this repository in a codespace from GitHub

Once in the dev container, all dependencies will be automatically set up.

### Installation and Releases

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version:
1. Update the version number in `lib/messages/api/version.rb`
2. Run `bundle exec rake release`

This will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/messages-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/messages-api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Messages::Api project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/messages-api/blob/master/CODE_OF_CONDUCT.md).
