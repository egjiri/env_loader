# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'env_loader/version'

Gem::Specification.new do |spec|
  spec.name          = 'env_loader'
  spec.version       = EnvLoader::VERSION
  spec.authors       = ['Endri Gjiri']
  spec.email         = ['egjiri@gmail.com']

  spec.summary       = 'Reads a YAML file and creates ENV variables from it'
  spec.description   = 'Reads a YAML file and creates ENV variables from it'
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
