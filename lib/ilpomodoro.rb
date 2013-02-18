class Ilpomodoro
  def initialize
    @pivotal = Pivotal.new
    @history = History.new 
  end

  def start
    loop do 
      task = @pivotal.get_task
      @history.add_or_create(task)
      do_a_pomodoro

      if current_task_finished?
        @github.commit(task) if was_doing_code? and wants_to_commit?
        @history.close_task(task)
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
  
  def current_task_finished? 
    agree("have you finish #{@history.current_task}?(y/n)")
  end

  def was_doing_code?
    agree("have you been doing code?(y/n)")
  end

  def wants_to_commit?
    agree("do you want to commit?(y/n)")
  end

  private 

  def  is_long_break?
    @iteration ||= 0
    @iteration += 1
    (@iteration % 3== 0)
  end
end


Dir["{lib}/ilpomodoro/**/*.rb"].each { |path| require_relative path.gsub('lib/','') }
require 'highline/import'
