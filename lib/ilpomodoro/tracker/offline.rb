require 'json'
require 'ilpomodoro/tracker/todoist_patch'

class Ilpomodoro::Tracker::Offline < Ilpomodoro::TaskTracker

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
      stories.each do |t|
        m.choice t
      end
      m.choice 'i would like to do other task...'
    end
  end

  def stories
    current_project.tasks
  end

  def projects
    Todoist::Project.all
  end

  def name
    'Todoist'
  end


end
