$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

# ---- Gem ----

task :gem => "gem:gem"
namespace :gem do
  require 'rake/gempackagetask'
  
  abort "Gemspec file not found" unless File.exists?('.gemspec')
  load '.gemspec'
  
  ::GEM_TASK = Rake::GemPackageTask.new(GEMSPEC) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
  end
  
  desc "Push the gem file #{::GEM_TASK.gem_file} to Gemcutter"
  task :release => :gem do
    sh "gem push #{::GEM_TASK.package_dir}/#{::GEM_TASK.gem_file}"
  end
end
