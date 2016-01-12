Gem::Specification.new do |s|
  s.name        = 'ruby-eigen'
  s.version     = '0.0.8'
  s.date        = '2016-01-12'
  s.summary     = "Ruby bindings for Eigen"
  s.description = "Ruby bindings for Eigen, a C++ template library for linear algebra. Implemented using SWIG."
  s.authors     = ["Takashi Tamura"]
  s.email       = ''
  s.files       = ["lib/eigen.rb", "ext/eigen/eigen_wrap.cxx"]
  s.extensions  = ["ext/eigen/extconf.rb"]
  s.homepage    = 'https://github.com/ruby-eigen/ruby-eigen'
  s.license     = 'MIT'
end
