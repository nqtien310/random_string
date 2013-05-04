require "bundler/gem_tasks"
require "random_string/version.rb"
require 'rspec/core/rake_task'

task :install_mah_gem do
  exec %{ 
  	gem uninstall random_string; 
  	gem build random_string.gemspec;
  	gem install random_string-#{RandomString::VERSION}.gem; }
end

task :default => :spec
RSpec::Core::RakeTask.new