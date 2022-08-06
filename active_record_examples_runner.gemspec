# frozen_string_literal: true

require_relative "lib/active_record_examples_runner/version"

Gem::Specification.new do |spec|
  spec.name          = "active_record_examples_runner"
  spec.version       = ActiveRecordExamplesRunner::VERSION
  spec.authors       = ["Benito horacio Serna Sandoval"]
  spec.email         = ["bhserna@gmail.com"]

  spec.summary       = "A tool for to run active record examples"
  spec.homepage      = "https://github.com/bhserna/active_record_examples_runner"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   << "run_examples_file"
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activerecord", "~> 7.0"
  spec.add_dependency "activesupport", "~> 7.0"
  spec.add_dependency "pg", "~> 1.3"
  spec.add_dependency "ffaker", "~> 2.21"
  spec.add_dependency "zeitwerk", "~> 2.6.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
