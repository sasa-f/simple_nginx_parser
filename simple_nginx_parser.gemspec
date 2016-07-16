# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_nginx_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_nginx_parser"
  spec.version       = SimpleNginxParser::VERSION
  spec.authors       = ["sasa_f"]
  spec.email         = ["-@-"]

  spec.summary       = %q{Simple Nginx configuration file parser}
  spec.description   = %q{
                          Simple Nginx Parser is parser of Nginx configuration file.
                          It translate Nginx configuration file to array objects. 
                          And it can search for the objects by some directive.
                         }
  spec.homepage      = ""

#  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
  spec.add_dependency "racc"
end
