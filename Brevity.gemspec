# -*- encoding: utf-8 -*-

require File.expand_path('../lib/brevity/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "Brevity"
  gem.version       = Brevity::VERSION
  gem.summary       = %q{Parse and process Brevity files. Convert them to other formats.}
  gem.description   = %q{Parse and process Brevity files, used for music notation. Convert them to other formats.}
  gem.license       = "MIT"
  gem.authors       = ["James Tunnell"]
  gem.email         = "jamestunnell@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/Brevity"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'yard', '~> 0.8'
end
