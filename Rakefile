$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'bundler'
require 'shellwords'
Bundler.setup

# ---- Gem ----

# Standard gem release process:
# 
#     rake gem:release
# 
# This will create a gem for the latest version and push it to
# <http://rubygems.org/>.
# 
task :gem => "gem:gem"
namespace :gem do
  require 'rake/gempackagetask'
  
  abort "Gemspec file not found" unless File.exists?('.gemspec')
  load '.gemspec'
  
  ::GEM_TASK = Rake::GemPackageTask.new(GEMSPEC) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
  end
  
  desc "Push the gem file #{::GEM_TASK.gem_file} to rubygems.org"
  task :release => :gem do
    sh "gem push #{::GEM_TASK.package_dir}/#{::GEM_TASK.gem_file}"
  end
end

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

require 'spec/rake/spectask'
require 'spec/version'

task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.libs = [File.expand_path(File.join(File.dirname(__FILE__), 'lib'))]
  t.pattern = "spec/**/*_spec.rb"
  t.spec_opts = (ENV["SPEC_OPTS"] || %{
    --color
    --format nested
  }).shellsplit
end
