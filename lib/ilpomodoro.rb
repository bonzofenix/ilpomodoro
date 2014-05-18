class Ilpomodoro
  attr_reader :task

  def initialize
    @h = HighLine.new
  end

  def work_offline?
    @work_offline ||= @h.agree('do you want to work offline?')
  end

  def get_task
    if work_offline?
      @h.ask 'i will be working on...'
    else
      tracker.login
      tracker.story
    end
  end

  def start
    loop do
      task = get_task
      do_a_pomodoro
      if finished?(task)
        git.commit(task) if was_doing_code? and wants_to_commit?
        #tracker.close(task)
        # history.close(task)
      else
        #tracker.close(task)
        # history.wip(task)
      end
      take_a_break
    end
  end


  def was_doing_code?
    agree("have you been doing code?(y/n)")
  end

  def wants_to_commit?
    agree("do you want to commit?(y/n)")
  end

  private
  def tracker
    @tracker ||= Ilpomodoro::TaskTracker.tracker
  end

  def history
    @history ||= History.new
  end

  def  is_long_break?
    @iteration ||= 0
    @iteration += 1
    (@iteration % 3== 0)
  end

  def take_a_break
    is_long_break? ? Timer.do_a(:long_break) : Timer.do_a(:short_break)
  end

  def finished?(task)
    agree("have you finish #{task}?(y/n)")
  end

  def do_a_pomodoro
    Timer.do_a(:pomodoro)
  end
end

class Ilpomodoro
  module Tracker
  end
end

require 'hashie'
require 'highline'
require 'ilpomodoro/history'
require 'ilpomodoro/timer'
require 'ilpomodoro/task_tracker'
require 'ilpomodoro/tracker/pivotal_tracker'
require 'ilpomodoro/tracker/todoist'
