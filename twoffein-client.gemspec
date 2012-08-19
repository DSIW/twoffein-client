# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twoffein-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["DSIW"]
  gem.email         = ["dsiw@dsiw-it.de"]
  gem.description   = %q{Client for twoffein.de API}
  gem.summary       = %q{Client for twoffein.de API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twoffein-client"
  gem.require_paths = ["lib"]
  gem.version       = Twoffein::Client::VERSION
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake','~> 0.9.2')
  gem.add_development_dependency('pry')
  gem.add_dependency('methadone', '~>1.0.0.rc4')
  gem.add_dependency('thor')
end
