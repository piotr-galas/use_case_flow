# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'use_case_flow/version'

Gem::Specification.new do |spec|
  spec.name          = 'use_case_flow'
  spec.version       = UseCaseFlow::VERSION
  spec.authors       = ['Piotr']
  spec.email         = ['galaspiotrek@gmail.com']

  spec.summary       = 'It provide readable control flow for use cases / services'
  spec.description   = 'You can use it in controller as a layer betwen controller and model'
  spec.homepage      = 'https://github.com/piotr-galas/use_case_flow'
  spec.license       = 'MIT'


  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
