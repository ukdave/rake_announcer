# frozen_string_literal: true

require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new

require_relative "lib/rake_announcer/rake_task"
RakeAnnouncer::RakeTask.new(tasks: %i[spec rubocop])

task default: %i[spec rubocop rake_announcer:ok]
