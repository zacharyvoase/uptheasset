$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'bundler'
require 'shellwords'

# Adds `build`, `install` and `release` tasks.
Bundler::GemHelper.install_tasks

# ---- Versioning ----

# Tasks for bumping the value in VERSION:
#
#     rake bump:bug  # 1.2.3 -> 1.2.4
#     rake bump:min  # 1.2.3 -> 1.3.0
#     rake bump:maj  # 1.2.3 -> 2.0.0
#
# These tasks will also do a `git commit` for the version bump:
#
#     git commit -m "Bumped to v1.2.4" VERSION
#
namespace :bump do
  def get_current_version
    File.read("VERSION").split(".").map(&:to_i)
  end

  def write_current_version(ver)
    File.open("VERSION", "w") { |f| f << ver.join(".") }
    FileUtils.touch("VERSION")
    sh "git", "commit", "-m", "Bumped to v#{ver.join(".")}", "VERSION"
  end

  desc "Increment this project's bugfix version (1.2.x)"
  task :bug do
    ver = get_current_version
    ver[2] += 1
    write_current_version(ver)
  end

  desc "Increment this project's minor version (1.x.3)"
  task :min do
    ver = get_current_version
    ver[1] += 1
    ver[2] = 0
    write_current_version(ver)
  end

  desc "Increment this project's major version (x.2.3)"
  task :maj do
    ver = get_current_version
    ver[0] += 1
    ver[1] = 0
    ver[2] = 0
    write_current_version(ver)
  end
end

# ---- RSpec ----

require 'rspec/core/rake_task'

task :default => :spec
spec = RSpec::Core::RakeTask.new do |t|
  t.verbose = false
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = (ENV["RSPEC_OPTS"] || %{
    --color
    --format nested
    -I #{File.expand_path(File.join(__FILE__, "..", "lib"))}
    -r #{File.expand_path(File.join(__FILE__, "..", "spec", "spec_helper.rb"))}
  }).shellsplit
end

# ---- YARD ----

require 'yard'

task :doc => :yard
YARD::Rake::YardocTask.new do |yard|
  yard.files = ['lib/**/*.rb', '-', 'AUTHORS', 'UNLICENSE', 'VERSION']
  yard.options = (ENV["YARD_OPTS"] || %{
    --title "#{GEMSPEC.name} v#{GEMSPEC.version}"
    --output-dir doc/yard
    --protected
    --no-private
    --hide-void-return
    --markup markdown
    --readme README.md
  }).shellsplit
end
