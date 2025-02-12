# frozen_string_literal: true

RSpec.describe RakeAnnouncer do
  it "has a version number" do
    expect(RakeAnnouncer::VERSION).not_to be_nil
  end

  describe ".announce_rake_task" do
    before do
      Rake::Task.define_task("dummy_task").clear
    end

    it "defines a new rake task" do
      described_class.announce_rake_task("dummy_task")
      expect(Rake::Task.tasks.map(&:name)).to include("announce_dummy_task")
    end

    it "adds the new rake task as a pre-requisite to the original task" do
      described_class.announce_rake_task("dummy_task")
      expect(Rake::Task["dummy_task"].prerequisites).to include("announce_dummy_task")
    end

    it "prints an announcement when the original task is invoked" do
      described_class.announce_rake_task("dummy_task")
      expect { Rake::Task["dummy_task"].invoke }.to output(/Running dummy_task/).to_stdout
    end

    it "appends announce tasks by default" do
      Rake::Task["dummy_task"].enhance(["pre_task"])
      expect { described_class.announce_rake_task("dummy_task") }
        .to change { Rake::Task["dummy_task"].prereqs }
        .from(%w[pre_task])
        .to(%w[pre_task announce_dummy_task])
    end

    it "can optionally prepend announce tasks" do
      Rake::Task["dummy_task"].enhance(["pre_task"])
      expect { described_class.announce_rake_task("dummy_task", prepend: true) }
        .to change { Rake::Task["dummy_task"].prereqs }
        .from(%w[pre_task])
        .to(%w[announce_dummy_task pre_task])
    end
  end

  describe ".announce" do
    it "prints the given message prefixed with a dot" do
      expect { described_class.announce("Foo") }.to output(/● Foo/).to_stdout
    end
  end

  describe ".ok" do
    it "prints a default message" do
      expect { described_class.ok }.to output(/ ALL TESTS PASSED /).to_stdout
    end

    it "prints a custom message" do
      expect { described_class.ok("IT WORKS") }.to output(/ IT WORKS /).to_stdout
    end
  end
end
