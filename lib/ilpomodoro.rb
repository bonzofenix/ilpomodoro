class Ilpomodoro
  attr_reader :task
  def start
    init_project_management

    loop do 
      choose_from_tasks
      do_a_pomodoro
      if finished?(task)
        git.commit(task) if was_doing_code? and wants_to_commit?
        history.close(task)
      else
        history.wip(task)
      end 
      take_a_break
    end
  end

  def choose_from_tasks

    @task = choose do |m|
      m.header= 'which of the following task will you be working on?'
      Ilpomodoro::ProjectManagement.tasks.each{ |t| m.choice t }
      m.choice 'i would like to do other task...'
    end
  end

  def init_project_management
    Ilpomodoro::ProjectManagement.tap do |klass|
      klass.choose_from_services
      klass.login
      klass.choose_from_projects
    end
  end

  def do_a_pomodoro 
    Timer.do_a(:pomodoro)
  end

  def take_a_break
    is_long_break? ? Timer.do_a(:long_break) : Timer.do_a(:short_break)
  end

  def first_time? 
   File.exists?('.ilpomodoro-configs')
  end

  def has_pivotaltracker?
    agree('Do you have tasks in pivotaltracker?')
  end

  def was_doing_code?
    agree("have you been doing code?(y/n)")
  end

  def wants_to_commit?
    agree("do you want to commit?(y/n)")
  end

  private 
  
  def history
    @history ||= History.new
  end

  def  is_long_break?
    @iteration ||= 0
    @iteration += 1
    (@iteration % 3== 0)
  end

  def get_task
    ask('in this pomodoro i will be working on...')
  end

  def finished?(task) 
    agree("have you finish #{task}?(y/n)")
  end
end

require 'logging'
require 'highline/import'
require 'hashie'
require 'ilpomodoro/history'
require 'ilpomodoro/timer'
require 'ilpomodoro/project_managment'
require 'pivotal-tracker'
