# frozen_string_literal: true

require_relative "lib/unity/dynamodbstreams/event_processor/version"

Gem::Specification.new do |spec|
  spec.name          = 'unity-dynamodbstreams-event-processor'
  spec.version       = Unity::DynamoDBStreams::EventProcessor::VERSION
  spec.authors       = ["Julien D."]
  spec.email         = ["julien@pocketsizesun.com"]

  spec.summary       = 'DynamoDB Streams - Event Processor'
  spec.description   = 'DynamoDB Streams - Event Processor'
  spec.homepage      = 'https://github.com/pocketsizesun/unity-dynamodbstreams-event-processor-ruby'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/pocketsizesun/unity-dynamodbstreams-event-processor-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/pocketsizesun/unity-dynamodbstreams-event-processor-ruby'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency 'unity-dynamodbstreams-event-parser', '~> 1.0'
  spec.add_development_dependency 'ox', '~> 2.14'
  spec.add_development_dependency 'aws-sdk-dynamodbstreams', '~> 1.0'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
