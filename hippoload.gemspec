# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hippoload/version'

Gem::Specification.new do |gem|
  gem.name          = "hippoload"
  gem.version       = Hippoload::VERSION
  gem.authors       = ["Santosh Wadghule"]
  gem.email         = ["santosh.wadghule@gmail.com"]
  gem.description   = %q{Ruby wrapper for httperf}
  gem.summary       = %q{It also parses the httperf output and converts parsed data into CSVs files}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
