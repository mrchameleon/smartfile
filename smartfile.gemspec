# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'smartfile/version'
 
Gem::Specification.new do |s|
  s.name        = "smartfile"
  s.version     = "0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan L. Johnson"]
  s.email       = ["rjs6143(at)gmail.com"]
  s.homepage    = "https://github.com/mrchameleon/smartfile"
  s.summary     = "An unoffical SmartFile API Wrapper"
  s.description = "Easily use the SmartFile APIs within your ruby or rails project."
 
  s.required_rubygems_version = ">= 1.3.6"
  s.required_ruby_version = ">= 1.8.7"
 
  #s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(README.md ROADMAP.md CHANGELOG.md)
  s.require_path = 'lib'
end
