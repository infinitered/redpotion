# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "redpotion"
  spec.version       = VERSION
  spec.authors       = ["Todd Werth"]
  spec.email         = ["todd@infinitered.com"]
  spec.description   = %q{RedPotion}
  spec.summary       = %q{RedPotion}
  spec.homepage      = "https://github.com/infinitered/redpotion"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'ruby_motion_query', '>= 0.8.0'
  spec.add_runtime_dependency "ProMotion", "~> 2.0.0"
  spec.add_runtime_dependency "cdq"
  spec.add_runtime_dependency "afmotion"
  spec.add_runtime_dependency "motion_print"
  spec.add_development_dependency "rake"
end
