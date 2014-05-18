# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'ilpomodoro'
  s.version     = '0.0.1'
  s.authors     = ['Alan Moran']
  s.email       = 'bonzofenix@gmail.com'
  s.summary     =  'Pomodoro technique on pivotal tracker'
  s.description = 'mother of productivity'
  s.files   = `git ls-files`.split($/)
  s.require_path = ['lib']
  s.homepage    = 'http://rubygems.org/gems/ilpomodoro'
  s.executables  << 'ilpomodoro'

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-core"
  s.add_development_dependency "rake"
  s.add_development_dependency "cancun"
  s.add_dependency 'hashie'
  s.add_dependency 'logging'
  s.add_dependency 'highline'
  s.add_dependency 'terminal-notifier'
  s.add_dependency 'pivotal-tracker'
  s.add_dependency 'todoist'
end
