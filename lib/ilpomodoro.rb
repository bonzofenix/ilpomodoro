class Ilpomodoro
  attr_reader :current_task, :pomodoro_number

  include Ilpomodoro::HighlineHelper

  def initialize
    @pomodoro_number = 1
    unless work_offline?
      tracker.login
    end
  end

  def work_offline?
    @work_offline ||= @highline.agree('do you want to work offline? (y/n)')
  end

  def choose_task
    if work_offline?
      @current_task = ask('i will be working on...')
    else
      tracker.choose_task
    end
  end

  def start
    loop do
      do_a_pomodoro
      take_a_break
    end
  end

  def stop
    history.close(@iteration, tracker.story)
    ask('i will be working on...')
  end


  def was_doing_code?
    agree("have you been doing code? (y/n)")
  end

  def wants_to_commit?
    agree("do you want to commit? (y/n)")
  end

  private
  def tracker
    @tracker ||= Ilpomodoro::TaskTracker.tracker
  end

  def history
    @history ||= History.new
  end

  def is_long_break?
    @pomodoro_number ||= 0
    @pomodoro_number += 1
    @pomodoro_number % 3 == 0
  end

  def take_a_break
    is_long_break? ? Timer.do_a(:long_break) : Timer.do_a(:short_break)
  end

  def finished?(task)
    agree("have you finished #{task}? (y/n)")
  end

  def do_a_pomodoro
    if @current_task.nil? || wants_to_change_task?
      @current_task = choose_task
    end
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
require 'ilpomodoro/highline_helper'
require 'ilpomodoro/task_tracker'
require 'ilpomodoro/tracker/pivotal_tracker'
require 'ilpomodoro/tracker/todoist'
