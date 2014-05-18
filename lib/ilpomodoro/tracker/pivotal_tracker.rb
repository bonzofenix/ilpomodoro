require 'pivotal-tracker'
# require 'ilpomodoro/task_tracker'

PivotalTracker::Project.class_eval do
  def to_s
    self.name
  end
end

PivotalTracker::Story.class_eval do
  def to_s
    "(#{self.current_state}) #{self.name}"
  end
end

class Ilpomodoro::Tracker::PivotalTracker < Ilpomodoro::TaskTracker

  def login
    PivotalTracker::Client.token(username, password)
  end

  def project
    @project ||= choose do |m|
      m.header = 'in which project you will be working on?'
      projects.each do |p|
        m.choice p
      end
    end
  end

  def story
    choose do |m|
      m.header= 'which of the following task will you be working on?'
      stories.each do |t|
        m.choice t
      end
      m.choice 'i would like to do other task...'
    end
  end

  def stories
    project.stories.all(current_state: ['unscheduled','started'])
  end

  def projects
    PivotalTracker::Project.all
  end

end
