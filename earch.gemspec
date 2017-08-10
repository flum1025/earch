# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "earch/version"

Gem::Specification.new do |spec|
  spec.name          = "earch"
  spec.version       = Earch::VERSION
  spec.authors       = ["flum1025"]
  spec.email         = ["flum.1025@gmail.com"]

  spec.summary       = %q{Twitter timeline notify}
  spec.description   = %q{This application monitors the Twitter timeline and notifies Slack according to the conditions.}
  spec.homepage      = "https://github.com/flum1025/earch"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency 'twitter'
  spec.add_dependency 'twitter-stream-patch'
  spec.add_dependency 'hashie'
  spec.add_dependency 'slack-ruby-client'
end
