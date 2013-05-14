# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'each_line_reverse'
  spec.version       = '1.0.0'
  spec.authors       = ['Junegunn Choi']
  spec.email         = ['junegunn.c@gmail.com']
  spec.description   = %q{Read lines of a file in reverse order}
  spec.summary       = %q{Read lines of a file in reverse order}
  spec.homepage      = 'https://github.com/junegunn/each_line_reverse'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
end
