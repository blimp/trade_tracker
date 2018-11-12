# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trade_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = 'trade_tracker'
  spec.version       = TradeTracker::VERSION
  spec.authors       = ['Dave Lens', 'Davy Hellemans']
  spec.email         = ['dave@blimp.be', 'rubygems@bauffman.be']
  spec.summary       = %q{This Rails gem wants to make the implementation of TradeTracker (click + conversion logging) easier.}
  spec.homepage      = 'https://github.com/blimp/trade_tracker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 2.6'

  spec.add_dependency 'activesupport', '~> 3.2'
end
