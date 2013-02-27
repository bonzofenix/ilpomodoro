Gem::Specification.new do |s|
  s.name        = 'ilpomodoro'
  s.version     = '0.0.0'
  s.date        = '2010-04-28'
  s.summary     =  'pomodoro integrates with git, register what you do in your pomodoros'
  s.description = 'mother of productivity'
  s.authors     = ['Alan Moran']
  s.email       = 'bonzofenix@gmail.com'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
  s.homepage    = 'http://rubygems.org/gems/ilpomodoro'
  s.executables  << 'ilpomodoro'

  s.add_development_dependency "debugger"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_dependency 'hashie'
  s.add_dependency 'logging'
  s.add_dependency 'highline'
  s.add_dependency 'terminal-notifier'
  s.add_dependency 'pivotal-tracker'
end
