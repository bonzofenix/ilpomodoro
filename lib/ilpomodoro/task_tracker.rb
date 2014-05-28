class Ilpomodoro::TaskTracker

  include Ilpomodoro::HighlineHelper

  def username
    @username ||= ask("enter your #{self.name}  username:")
  end

  def password
    @password ||= ask("enter your #{self.name}  password:"){ |q| q.echo = 'x' }
  end

  def name
    'undefined'
  end

  def choose_task
    raise 'not implemented'
  end

  def self.tracker
    @tracker ||= HighLine.new.choose do |menu|
      menu.choice('PivotalTracker') do Ilpomodoro::Tracker::PivotalTracker.new end
      menu.choice('Todoist') do Ilpomodoro::Tracker::Todoist.new end 
    end
  end

end
