# RakeAnnouncer

[![Build Status](https://github.com/ukdave/rake_announcer/actions/workflows/main.yml/badge.svg)](https://github.com/ukdave/rake_announcer/actions/workflows/main.yml)
[![Release](https://img.shields.io/github/v/release/ukdave/rake_announcer)](https://github.com/ukdave/rake_announcer/releases)
[![License](https://img.shields.io/github/license/ukdave/rake_announcer)](https://github.com/ukdave/rake_announcer/blob/main/LICENSE.txt)

A small gem to enhance existing rake tasks by printing a brief message before each one is invoked. The list of tasks to wrap/enhance is configurable. Also included is a task to print a simple and colourful "All Tests Passed" message.

This gem was inspired by [Rake-n-Bake](https://github.com/RichardVickerstaff/rake-n-bake).

![Screenshot](screenshot.png?raw=true "Screenshot")

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add rake_announcer
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install rake_announcer
```

## Usage

Add the following to your Rakefile:

```ruby
require "rake_announcer/rake_task"
RakeAnnouncer::RakeTask.new(tasks: %i[spec rubocop])
```

Include the names of any rake tasks that you want announced in the `tasks` array. The above example will print a message before the `spec` and `rubocop` tasks run.

If you have a default Rake task defined you can automatically announce all of the dependent tasks like so avoiding any duplication:

```ruby
task default: %i[spec rubocop]

require "rake_announcer/rake_task"
RakeAnnouncer::RakeTask.new(tasks: Rake::Task[:default].prereqs, prepend: true)
```

By default announcements are displayed immediately before each task runs, but after the task's dependencies/prerequisites have run. If you prefer the announcement to be displayed before any of the task's dependencies/prerequisites have run then you can use the `prepend: true` option.

Finally, you can print a simple "All Tests Passed" message by adding the `rake_announcer:ok` task, e.g.:

```ruby
task default: %i[spec rubocop rake_announcer:ok]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, run `bundle exec rake semver:XXX` (replacing `XXX` with `major` or `minor` or `patch`), which will bump the version number and create a git tag for the version. Then run `git push origin main --tags` to push the new tag.

Then run `bundle exec rake release`, which will build and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ukdave/rake_announcer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
