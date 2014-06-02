require 'logging'

class Ilpomodoro::History
  def initialize
    Logging.format_as(:yaml)
    Logging.logger.root.level = :info
    Logging.logger.root.appenders << get_appenders
  end


  def start_pomodoro(task)
    
  end

  def end_pomodoro(task)

  end

  def start(iteration, task)
    log.info text_for(iteration, task, :start)
  end

  def wip(iteration, task)
    log.info text_for(iteration, task, :wip)
  end

  def close(iteration, task)
    log.info text_for(iteration, task, :closed)
  end

  def get_appenders
    filename = '.ilpomodoro'
    folder_path = Pathname.new(`pwd`)
    home_path = Pathname.new('~/filename')

    Array.new.tap do |a|
      a << Logging.appenders.file(home_path)
      a << Logging.appenders.file(folder_path)
    end
  end

  private

  def text_for(iteration, task, status)
    "{iteration}, #{username}, #{task}, #{status.to_s}"
  end

  def username
    `git config user.name`.strip
  end

  def log
    @log ||= Logging.logger[self]
  end
end
