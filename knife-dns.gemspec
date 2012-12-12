# -*- encoding: utf-8 -*-
require File.expand_path('../lib/knife-dns/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stephen Lauck"]
  gem.email         = ["stpehen.lauck@gmail.com"]
  gem.summary       = %q{DNS Support for Chef's Knife Command}
  gem.description   = gem.summary
  gem.homepage      = "https://github.com/stephenlauck/knife-dns"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "knife-dns"
  gem.require_paths = ["lib"]
  gem.version       = Knife::Dns::VERSION

  gem.add_dependency "fog", "~> 1.6"
  gem.add_dependency "chef", ">= 0.10.0"
end
