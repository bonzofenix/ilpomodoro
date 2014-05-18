require 'todoist'
require 'json'
# require 'ilpomodoro/task_tracker'

module Todoist
  class Base

    def self.get_token(email, password)
      response = login(email, password)
      body = JSON.parse(response.body)
      puts response.inspect
      puts response['token']
      body['token']
    end

    def self.login(email, password)
      # base_uri 'http://todoist.com/API'
      HTTParty.post('http://todoist.com/API/login', {body: {email: email, password: password}})
    end

  end
end


# def notify_about_requirements_and_exit
#   puts "You need to setup ~/.todoistrc"
#   exit(1)  
# end

# def load_config(config_file = '~/.todoistrc')
#   keys = %w(email password)
#   if File.file?(File.expand_path('~/.todoistrc'))
#     config = YAML.load_file(File.expand_path('~/.todoistrc'))
#     unless (config['email'] && config['password']) || config['token'] do
#       notify_about_requirements_and_exit
#     end
#   else
#     puts "You can save your credentions in #{config_file} file."
#     @h.ask {}
#   end
# end

# def setup_todoist_base
#   if File.file?(File.expand_path('~/.todoistrc'))
#     config = YAML.load_file(File.expand_path('~/.todoistrc'))
#     unless (config['email'] && config['password']) || config['token'] do
#       notify_about_requirements_and_exit
#     end
#   else
#     notify_about_requirements_and_exit
#   end


#   response = Todoist::Base.get('/login', {email: email, password: password})
#   response['token']
#   Todoist::Base.setup(conf['token'], conf['premium'])
# end

Todoist::Task.class_eval do
  def to_s
    self.content
  end
end

class Ilpomodoro::Tracker::Todoist < Ilpomodoro::TaskTracker

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

  def story
    @story ||= @highline.choose do |m|
      m.header= 'which of the following task will you be working on?'
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
