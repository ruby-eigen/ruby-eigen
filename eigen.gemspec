Gem::Specification.new do |s|
  s.name        = 'ruby-eigen'
  s.version     = '0.0.8'
  s.date        = '2016-01-12'
  s.summary     = ""
  s.description = "CRuby binding for Eigen"
  s.authors     = ["TAMURA Takashi"]
  s.email       = ''
  s.files       = ["lib/eigen.rb"]
  s.extensions = ["ext/eigen/extconf.rb"]
  s.homepage    =
    'https://github.com/ruby-eigen/ruby-eigen'
  s.license       = 'MIT'
end
