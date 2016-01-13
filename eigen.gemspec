Gem::Specification.new do |s|
  s.name        = 'ruby-eigen'
  s.version     = '0.0.9'
  s.date        = '2016-01-13'
  s.summary     = "Ruby bindings for Eigen"
  s.description = "Ruby bindings for Eigen, a C++ template library for linear algebra. Implemented using SWIG. To install this gem, you have to specify the header dir of Eigen. See https://github.com/ruby-eigen/ruby-eigen for detail."
  s.authors     = ["Takashi Tamura"]
  s.email       = ''
  s.files       = ["lib/eigen.rb", "ext/eigen/eigen_wrap.cxx"]
  s.extensions  = ["ext/eigen/extconf.rb"]
  s.homepage    = 'https://github.com/ruby-eigen/ruby-eigen'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rake-compiler', '~> 0.9.5'
end
