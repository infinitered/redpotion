# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
VERSION = "0.2"

Gem::Specification.new do |spec|
  spec.name          = "redpotion"
  spec.authors       = ["InfiniteRed", "ClearSight Studio"]
  spec.email         = ["hello@infinitered.com", "hello@clearsightstudio.com" ]
  spec.description   = %q{RedPotion - The best combination of RubyMotion tools and libraries}
  spec.summary       = %q{RedPotion combines RMQ, ProMotion, CDQ, AFMotion, and more for the perfect mix to develop in RubyMotion fast}
  spec.homepage      = "https://github.com/infinitered/redpotion"
  spec.license       = "MIT"

  spec.files         = Dir.glob('lib/**/*.rb')
  spec.files         << 'README.md'

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.version       = VERSION

  spec.add_runtime_dependency 'ruby_motion_query', '~> 0.8'
  spec.add_runtime_dependency "ProMotion", "~> 2.0"
  spec.add_runtime_dependency "cdq"
  spec.add_runtime_dependency "afmotion"
  spec.add_runtime_dependency "motion_print"
  spec.add_development_dependency "rake"
end
