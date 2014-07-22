# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "kimsufi-availability"
  spec.version       = '1.0.0'
  spec.authors       = ["MyDigitalPRO"]
  spec.email         = ["info@mdtlpr.com"]
  spec.summary       = %q{Get and parse kimsufi servers availabilities from OVH}
  spec.description   = %q{Get and parse kimsufi servers availabilities from OVH https://ws.ovh.com/dedicated/r2/ws.dispatcher/getAvailability2}
  spec.homepage      = "https://github.com/MyDigitalPRO/KimsufiAvailability"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 10.3'
end
