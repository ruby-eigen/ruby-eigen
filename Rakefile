require "rake/extensiontask"
require 'rake/testtask'

Rake::ExtensionTask.new "eigen" do |ext|
  ext.lib_dir = "lib/eigen"
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
