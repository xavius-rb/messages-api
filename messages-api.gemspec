# frozen_string_literal: true

require_relative "lib/messages/api/version"

Gem::Specification.new do |spec|
  spec.name = "messages-api"
  spec.version = Messages::Api::VERSION
  spec.authors  = ["Emerson Xavier"]
  spec.email    = ["msxavii@gmail.com"]

  spec.summary = "Wrapper for sending SMS via services like Message Media, Twilio, etc."
  spec.description = "This gem provides a unified interface for sending SMS messages through various service providers, including Message Media and Twilio. It simplifies the process of integrating SMS functionality into your Ruby applications, allowing you to send messages with ease and flexibility."
  spec.homepage = "https://github.com/xavius-rb/messages-api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/xavius-rb/messages-api/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
