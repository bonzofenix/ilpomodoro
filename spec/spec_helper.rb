require 'rubygems'
require 'bundler/setup'
require 'ilpomodoro' 
require 'rspec/logging_helper'

RSpec.configure do |config|
 #include RSpec::LoggingHelper
 #config.capture_log_messages

  # Lets mock rails root!
  config.before do
    class ::Rails
    end
    path = Pathname.new('spec/dummy/')
    Rails.stub(root: path)
  end
end
