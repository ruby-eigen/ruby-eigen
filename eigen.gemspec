Gem::Specification.new do |s|
  s.name        = 'ruby-eigen'
  s.version     = '0.0.11.pre2'
  s.date        = '2016-03-27'
  s.summary     = "Ruby bindings for Eigen"
  s.description = "Ruby bindings for Eigen, a C++ template library for linear algebra. Implemented using SWIG."
  s.authors     = ["Takashi Tamura"]
  s.email       = ''
  s.files       = ["LICENSE", "COPYING.LGPLv3",
                   "README.md",
                   "lib/eigen.rb",
                   "ext/eigen/eigen_wrap.cxx"] +
    Dir.glob("ext/eigen/*.h") +
    Dir.glob("ext/eigen/eigen3/**/*")
  s.extensions  = ["ext/eigen/extconf.rb"]
  s.homepage    = 'https://github.com/ruby-eigen/ruby-eigen'
  s.license     = 'LGPL-3.0'
  s.add_runtime_dependency 'rake-compiler', '~> 0.9.5'
  s.rdoc_options << "--exclude=."
  s.required_ruby_version = '>= 2.2.0'
end
