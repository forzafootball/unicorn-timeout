# -*- encoding: utf-8 -*-
require File.expand_path('../lib/unicorn/timeout/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anders Carling"]
  gem.email         = ["anders.carling@d05.se"]
  gem.description   = %q{Middleware for timing out current unicorn worker if request takes to long time.}
  gem.summary       = %q{Middleware for timing out current unicorn worker if request takes to long time.}
  gem.homepage      = "http://www.github.com/FootballAddicts/unicorn-timeout"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "unicorn-timeout"
  gem.require_paths = ["lib"]
  gem.version       = Unicorn::Timeout::VERSION

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
end
