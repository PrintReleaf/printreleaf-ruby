# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'printreleaf/version'

Gem::Specification.new do |spec|
  spec.name          = "printreleaf"
  spec.version       = PrintReleaf::VERSION
  spec.authors       = ["Casey O'Hara"]
  spec.email         = ["cohara@printreleaf.com"]
  spec.summary       = "Ruby toolkit for the PrintReleaf API"
  spec.description   = "Ruby toolkit for the PrintReleaf API"
  spec.homepage      = "https://github.com/printreleaf/printreleaf-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "hashie", "~> 3.4", ">= 3.4.6"
  spec.add_dependency "rest-client", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

