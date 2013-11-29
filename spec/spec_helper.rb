require 'bundler/setup'
require 'ilpomodoro'
require 'rspec/logging_helper'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.extend RSpec::LoggingHelper
  config.capture_log_messages
  config.before do
     Object.stub(:choose)
     Object.stub(:ask)
  end
end
