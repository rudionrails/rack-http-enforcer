# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-http-enforcer"
  s.version     = File.read('VERSION')
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rudolf Schmidt"]
  
  # s.email       = []
  s.homepage    = "http://github.com/rudionrails/rack-http-enforcer"
  s.summary     = "A simple Rack middleware to enforce HTTP"
  s.description = "Rack::HttpEnforcer is a simple Rack middleware to enforce http connections"
  
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rack-http-enforcer"
  
  s.add_development_dependency "bundler", "~> 1.0.7"
  s.add_development_dependency "jeweler", "~> 1.5.1"
  s.add_development_dependency "test-unit", "~> 2.1.2"
  s.add_development_dependency "shoulda", "~> 2.11.3"
  s.add_development_dependency "rack", "~> 1.2.1"
  s.add_development_dependency "rack-test", "~> 0.5.6"
  
  s.files        = Dir.glob("{lib}/**/*") + %w[LICENSE.txt README.rdoc]
  s.require_path = 'lib'
end
