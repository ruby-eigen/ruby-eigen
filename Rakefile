require "rake/extensiontask"
require 'rake/testtask'
require 'rake/clean'


elibs = ["eigen"]

elibs.each{|s|
  Rake::ExtensionTask.new s do |ext|
    ext.lib_dir = "lib/#{s}"
  end
}

namespace :swg do
  elibs.each{|f|
    task f do
      sh "swig -c++ -ruby ext/#{f}/#{f}.i"
    end
  }
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end
desc "Run tests"

task :swig => elibs.map{|f| "swg:#{f}" }
task :default => [:test]
task :build => [:swig, :compile]

