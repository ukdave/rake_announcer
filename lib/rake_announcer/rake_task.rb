# frozen_string_literal: true

require "rake/tasklib"
require "rake_announcer"

module RakeAnnouncer
  class RakeTask < Rake::TaskLib
    def initialize(name: :rake_announcer, tasks: [], prepend: false)
      super()

      namespace name do
        tasks.each do |t|
          RakeAnnouncer.announce_rake_task(t, prepend:) unless t.to_s.start_with?(name.to_s)
        end

        desc "Print the 'ALL TESTS PASSED' message"
        task :ok do
          RakeAnnouncer.ok
        end
      end
    end
  end
end
