require 'forwardable'

class Ilpomodoro::TaskTracker

  extend Forwardable

  def initialize
    @highline = HighLine.new
  end

  # def_delegator :highline, :ask, :choose
  # def self.highline
  #   @highline = HighLine.new
  # end

  def username
    @username ||= @highline.ask("enter your pivotaltracker  username:")
  end

  def password
    @password ||= @highline.ask("enter your pivotaltracker  password:"){ |q| q.echo = 'x' }
  end

  def name
    'undefined'
  end

  def self.tracker
    @tracker ||= HighLine.new.choose do |menu|
      menu.choice('PivotalTracker') do Ilpomodoro::Tracker::PivotalTracker.new end
      menu.choice('Todoist') do Ilpomodoro::Tracker::Todoist.new end 
    end
  end

end
