# frozen_string_literal: true

require "rake"
require "term/ansicolor"
require_relative "rake_announcer/version"

module RakeAnnouncer
  class Error < StandardError; end

  def self.announce_rake_task(task_name, prepend: false)
    announce_task = Rake::Task.define_task("announce_#{task_name}") do
      RakeAnnouncer.announce("Running #{task_name}")
    end

    if prepend
      Rake::Task[task_name].prereqs.prepend(announce_task.name)
    else
      Rake::Task[task_name].enhance([announce_task.name])
    end
  end

  def self.announce(message)
    puts "\n#{Term::ANSIColor.blue}#{Term::ANSIColor.underline}● #{message}#{Term::ANSIColor.reset}"
  end

  # rubocop:disable Metrics/MethodLength
  def self.ok(message = "ALL TESTS PASSED")
    puts
    print Term::ANSIColor.bold,
          Term::ANSIColor.red,     "*",
          Term::ANSIColor.yellow,  "*",
          Term::ANSIColor.green,   "*",
          Term::ANSIColor.blue,    "*",
          Term::ANSIColor.magenta, "*",
          Term::ANSIColor.green,   " #{message} ",
          Term::ANSIColor.magenta, "*",
          Term::ANSIColor.blue,    "*",
          Term::ANSIColor.green,   "*",
          Term::ANSIColor.yellow,  "*",
          Term::ANSIColor.red,     "*",
          Term::ANSIColor.clear
    puts
  end
  # rubocop:enable Metrics/MethodLength
end
