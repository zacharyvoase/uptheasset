require 'rubygems'
require 'bundler'
require 'rake'

GEMSPEC = Gem::Specification.new do |gem|
  gem.version            = File.read("VERSION").chomp
  gem.date               = File.mtime("VERSION").strftime("%Y-%m-%d")

  gem.name               = "name"
  gem.summary            = "summary"
  gem.description        = "description"
  gem.homepage           = "http://github.com/zacharyvoase/name"
  gem.license            = "Public Domain" if gem.respond_to?(:license=)

  gem.authors            = ["Zachary Voase"]
  gem.email              = "z@zacharyvoase.com"

  gem.platform           = Gem::Platform::RUBY
  gem.files              = FileList["{bin,lib,spec}/**/*", "AUTHORS", "README.md", "UNLICENSE", "VERSION"]
  gem.bindir             = "bin"
  gem.executables        = FileList["bin/*"].pathmap("%f")
  gem.require_paths      = ["lib"]
  gem.extensions         = []
  gem.test_files         = FileList["spec/**/*"]
  gem.has_rdoc           = false

  gem.required_ruby_version      = ">= 1.8.6"
  gem.add_bundler_dependencies
end
