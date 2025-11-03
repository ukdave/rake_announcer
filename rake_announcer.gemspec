# frozen_string_literal: true

require_relative "lib/rake_announcer/version"

Gem::Specification.new do |spec|
  spec.name = "rake_announcer"
  spec.version = RakeAnnouncer::VERSION
  spec.authors = ["David Bull"]
  spec.email = ["david@uk-dave.com"]

  spec.summary = "Print a message before each rake task"
  spec.description = <<~DESCRIPTION
    A small gem to enhance existing rake tasks by printing a brief message before each one is invoked. The list of tasks
    to wrap/enhance is configurable. Also included is a task to print a simple and colourful "All Tests Passed" message.
  DESCRIPTION
  spec.homepage = "https://github.com/ukdave/rake_announcer"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ukdave/rake_announcer"
  spec.metadata["changelog_uri"] = "https://github.com/ukdave/rake_announcer/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).select do |f|
      f.start_with?(*%w[CHANGELOG.md LICENSE.txt README.md lib])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rake", ">= 13"
  spec.add_dependency "term-ansicolor", "~> 1.11"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
