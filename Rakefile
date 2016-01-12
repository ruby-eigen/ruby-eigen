require "rake/extensiontask"

Rake::ExtensionTask.new "eigen" do |ext|
  ext.lib_dir = "lib/eigen"
end

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
