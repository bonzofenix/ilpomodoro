class Ilpomodoro
  class Tracker
  end
end

require 'hashie'
require 'highline'
require 'ilpomodoro/highline_helper'
require 'ilpomodoro/history'
require 'ilpomodoro/timer'
require 'ilpomodoro/task_tracker'
require 'ilpomodoro/tracker/todoist_patch'
require 'ilpomodoro/tracker/todoist'
require 'ilpomodoro/tracker/pivotal_tracker'
require 'ilpomodoro/tracker/offline'


class Ilpomodoro
  attr_reader :current_task, :pomodoro_number

  include Ilpomodoro::HighlineHelper

  def initialize
    @pomodoro_number = 0
    tracker.authenticate!
  end

  def choose_task
    tracker.choose_task
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
    @pomodoro_number % 4 == 0
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
    history.start_pomodoro(@current_task)
    Timer.do_a(:pomodoro)
    @pomodoro_number += 1
    history.add_comment if add_comment?
    history.finish_pomodoro(@current_task)
  end

  def add_comment?
    agree('do you want to add comment? (y/n)')
  end
end


