# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-glesys/version'

Gem::Specification.new do |gem|
  gem.name          = "knife-glesys"
  gem.version       = Knife::Glesys::VERSION
  gem.authors       = ["Simon Gate"]
  gem.email         = ["simon@smgt.me"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "fog", "~> 1.9"
  gem.add_dependency "chef", ">= 0.10.10"
end
