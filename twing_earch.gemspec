
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twing_earch/version'

Gem::Specification.new do |spec|
  spec.name          = 'twing_earch'
  spec.version       = TwingEarch::VERSION
  spec.authors       = ['flum1025']
  spec.email         = ['flum.1025@gmail.com']
  spec.summary       = 'Earch for Twing'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/flum1025/twing_earch'
  spec.license       = 'MIT'
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_dependency 'slack-ruby-client'
end
