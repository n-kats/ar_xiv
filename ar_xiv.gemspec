# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar_xiv/version'

Gem::Specification.new do |spec|
  spec.name          = "ar_xiv"
  spec.version       = ArXiv::VERSION
  spec.authors       = ["Katsunori Nakanishi"]
  spec.email         = ["n-kats19890214@hotmail.co.jp"]
  spec.licenses      = "MIT"
  spec.summary       = %q{simple request to arXiv}
  spec.description   = %q{simple request to arXiv and get data}
  spec.homepage      = "https://github.com/n-kats/ar_xiv"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 0"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard", "~> 2.1"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
end
