# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sogou/version'

Gem::Specification.new do |spec|
  spec.name          = "sogou"
  spec.version       = Sogou::VERSION
  spec.authors       = ["seoaqua"]
  spec.email         = ["seoaqua@me.com"]
  spec.description   = %q{sogou web services}
  spec.summary       = %q{sogou sem services}
  spec.homepage      = "http://github.com/seoaqua/sogou"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "savon","~> 3.0"
end
