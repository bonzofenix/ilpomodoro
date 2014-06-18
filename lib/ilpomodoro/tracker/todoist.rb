require 'json'
require 'ilpomodoro/tracker/todoist_patch'

class Ilpomodoro::Tracker::Todoist < Ilpomodoro::TaskTracker

  def authenticate!
    Todoist::Base.login(username, password)
  end
 
  def choose_project
    @current_project = choose do |m|
      m.header = 'in which project you will be working on?'
      projects.each do |p|
        m.choice p
      end
    end
  end

  def choose_task
    @current_task = choose do |m|
      m.header = 'which of the following task will you be working on?'
      tasks.each do |t|
        m.choice t
      end
      m.choice 'i would like to do other task...'
    end
  end

  def tasks
    self.choose_project if current_project.nil?
    current_project.tasks
  end

  def projects
    Todoist::Project.all
  end

  def name
    'Todoist'
  end


end
