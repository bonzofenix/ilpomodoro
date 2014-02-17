class Ilpomodoro
  attr_reader :task
  def start
    loop do
      task = tracker.story
      do_a_pomodoro
      if finished?(task)
        git.commit(task) if was_doing_code? and wants_to_commit?
        # history.close(task)
      else
        # history.wip(task)
      end
      take_a_break
    end
  end


  def do_a_pomodoro
    Timer.do_a(:pomodoro)
  end

  def was_doing_code?
    agree("have you been doing code?(y/n)")
  end

  def wants_to_commit?
    agree("do you want to commit?(y/n)")
  end

  private
  def tracker
    @tracker ||= Ilpomodoro::PivotalTracker.new
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
end

require 'highline'
require 'hashie'
require 'ilpomodoro/history'
require 'ilpomodoro/timer'
require 'ilpomodoro/pivotal_tracker'
