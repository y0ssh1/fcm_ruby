# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'fcm_ruby'
  spec.version       = '0.1.0'
  spec.authors       = ['y0ssh1']
  spec.email         = ['yosshi0774@gmail.com']

  spec.summary       = 'Firebase messaging client for ruby'
  spec.description   = 'fcm_ruby is firebase messaging wrapper using HTTP v1 API to send notification to single token and also using legacy API to send notifications to multiple tokens'
  spec.homepage      = 'https://github.com/y0ssh1/fcm_ruby.git'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/y0ssh1/fcm_ruby.git'
  spec.metadata['changelog_uri'] = 'https://github.com/y0ssh1/fcm_ruby.git/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'webmock', '3.8.3'
  spec.add_runtime_dependency 'faraday', '1.0.0'
end
