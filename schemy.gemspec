# -*- encoding: utf-8 -*-
require File.expand_path('../lib/schemy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ian C. Anderson"]
  gem.email         = ["anderson.ian.c@gmail.com"]
  gem.description   = %q{Analyzes schema.rb to suggest new database indexes, providing a migration file that can be used directly.}
  gem.summary       = %q{Analyzes schema.rb to suggest new database indexes.}
  gem.homepage      = 'http://rubygems.org/gems/schemy'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "schemy"
  gem.require_paths = ["lib"]
  gem.version       = Schemy::VERSION
end
