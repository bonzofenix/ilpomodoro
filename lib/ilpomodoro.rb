require 'ilpomodoro/console_interaction'

class Ilpomodoro
  include ConsoleInteraction

  def initialize
    intial_configuration if first_time?
  end

  def start
    loop do 
      task ||= get_task 
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
  
 
  def do_a_pomodoro 
    Timer.do_a(:pomodoro)
  end

  def take_a_break
    is_long_break? ? Timer.do_a(:long_break) : Timer.do_a(:short_break)
  end

  def configure_third_parties
    get_pivotal_params
  end

  def first_time? 
   File.exists?('.ilpomodoro-configs')
  end

  private 
  

    
  def history
    @history ||= History.new
  end

  def task_manager
    @pivotal ||= Pivotal.new
  end

  def  is_long_break?
    @iteration ||= 0
    @iteration += 1
    (@iteration % 3== 0)
  end
end

require 'logging'
require 'highline/import'
require 'hashie'
require 'ilpomodoro/history'
require 'ilpomodoro/timer'
require 'ilpomodoro/project_managment_service'
require 'ilpomodoro/console_interaction'
