
class Ilpomodoro::TaskTracker

  

  include Ilpomodoro::HighlineHelper
  
  attr_accessor :current_task, :current_project

  def username
    @username ||= ask("enter your #{self.name}  username:")
  end

  def password
    @password ||= ask("enter your #{self.name}  password:"){ |q| q.echo = 'x' }
  end

  def name
    raise :not_implemented
  end

  def choose_task
    raise :not_implemented
  end

  def choose_task
    raise :not_implemented
  end

  def self.tracker
    @tracker ||= HighLine.new.choose do |menu|
      menu.choice('PivotalTracker') do Ilpomodoro::Tracker::PivotalTracker.new end
      menu.choice('Todoist') do Ilpomodoro::Tracker::Todoist.new end 
      menu.choice('Offline') do Ilpomodoro::Tracker::Offline.new end 
    end
  end

end

