require 'pivotal-tracker'
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

class Ilpomodoro::PivotalTracker
  @@project = nil

    def initialize
      login
      choose_from_projects
    end

    def login
      PivotalTracker::Client.token(get_username, get_password)
    end

    def choose_from_projects
      @@project = choose do |m|
        m.header = 'in which project you will be working on?'
        projects.each do |p|
          m.choice p
        end
      end
    end

    def tasks
      project.stories.all(current_state: ['unscheduled','started'])
    end

    def projects
      PivotalTracker::Project.all
    end

    def get_username
      ask("enter your pivotaltracker  username:   ")
    end

    def get_password
      ask("enter your pivotaltracker  password:   "){ |q| q.echo = 'x' }
    end

    def project
      @@project
    end
  end
