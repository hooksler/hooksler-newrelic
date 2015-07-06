# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hooksler/newrelic/version'

Gem::Specification.new do |spec|
  spec.name          = "hooksler-newrelic"
  spec.version       = Hooksler::Newrelic::VERSION
  spec.authors       = ["schalexey@gmail.com"]
  spec.email         = ["schalexey@gmail.com"]

  spec.summary       = %q{Newrelic adapter for hooksler.}
  spec.description   = %q{Newrelic adapter for hooksler.}
  spec.homepage      = "https://github.com/hooksler/hooksler-newrelic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "hooksler", '> 0.1.3'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'

end
