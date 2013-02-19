class Ilpomodoro
  include Ilpomodoro::ConsoleInteraction

  def initialize
    @pivotal = Pivotal.new
    @history = History.new 
  end

  def start
    loop do 
      task = @pivotal.get_task
      task ||= get_task 
      @history.start_session      
      do_a_pomodoro

      if current_task_finished?
        @github.commit(task) if was_doing_code? and wants_to_commit?
        @history.close(task)
      else
        @history.wip(task)
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

  private 

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
require 'ilpomodoro/console_interaction'
require 'ilpomodoro/timer'
require 'ilpomodoro/pivotal'
