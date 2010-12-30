# -*- encoding: utf-8 -*-

require 'rubygems'
require 'rake'

GEMSPEC = Gem::Specification.new do |gem|
  gem.version            = File.read("VERSION").chomp
  gem.date               = File.mtime("VERSION").strftime("%Y-%m-%d")

  gem.name               = "uptheasset"
  gem.summary            = "RDF-enhanced bookkeeping and accounting."
  gem.description        = "A suite of bookkeeping and accounting utilities, using RDF."
  gem.homepage           = "http://github.com/zacharyvoase/uptheasset"
  gem.rubyforge_project  = "nowarning"
  gem.license            = "Public Domain" if gem.respond_to?(:license=)

  gem.authors            = ["Zachary Voase"]
  gem.email              = "z@zacharyvoase.com"

  gem.platform           = Gem::Platform::RUBY
  gem.files              = FileList["{bin,lib,spec}/**/*", "AUTHORS", "README.md", "UNLICENSE", "VERSION"]
  gem.bindir             = "bin"
  gem.executables        = FileList["bin/*"].pathmap("%f")
  gem.require_paths      = ["lib"]
  gem.extensions         = []
  gem.test_files         = FileList["{test,spec,features}/**/*"]
  gem.has_rdoc           = false
  gem.has_yard           = true

  gem.required_ruby_version      = ">= 1.8.6"

  gem.add_dependency             "rdf",   "~> 0.3.0"
  gem.add_dependency             "spira", "~> 0.0.11"

  gem.add_development_dependency "rake",  "~> 0.8.7"
  gem.add_development_dependency "rspec", ">= 1.3.0"
  gem.add_development_dependency "yard",  "~> 0.5"
  gem.add_development_dependency "bluecloth" # For Markdown formatting in YARD.
end
