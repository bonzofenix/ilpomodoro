require 'todoist'
require 'json'

module Todoist
  class Base

    def self.get_token(email, password)
      response = login(email, password)
      body = JSON.parse(response.body)
      body['token']
    end

    def self.login(email, password)
      HTTParty.post('http://todoist.com/API/login', {body: {email: email, password: password}})
    end

  end
end


Todoist::Task.class_eval do
  def to_s
    self.content
  end
end

class Ilpomodoro::Tracker::Todoist < Ilpomodoro::TaskTracker

  attr_accessor :story

  def login
    @token ||= Todoist::Base.get_token(username, password)
    Todoist::Base.setup(@token, true)
  end
 
  def project
    @project ||= @highline.choose do |m|
      m.header = 'in which project you will be working on?'
      projects.each do |p|
        m.choice p
      end
    end
  end

  def choose_story
    @story = @highline.choose do |m|
      m.header = 'which of the following task will you be working on?'
      stories.each do |t|
        m.choice t
      end
      m.choice 'i would like to do other task...'
    end
  end

  def stories
    project.tasks
  end

  def projects
    Todoist::Project.all
  end

end
