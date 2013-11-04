# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'env_loader/version'

Gem::Specification.new do |spec|
  spec.name          = "env_loader"
  spec.version       = EnvLoader::VERSION
  spec.authors       = ["Endri Gjiri"]
  spec.email         = ["egjiri@gmail.com"]
  spec.description   = %q{Reads a YAML file and creates ENV variables from it}
  spec.summary       = %q{Reads a YAML file and creates ENV variables from it}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
