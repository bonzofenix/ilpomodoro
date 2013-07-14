class Ilpomodoro::History

  def initialize
    Logging.format_as(:yaml)
    Logging.logger.root.level = :info
    Logging.logger.root.appenders << get_appenders
  end


  def start(task)
    log.info text_for(task, :start)
  end

  def wip(task)
    log.info text_for(task, :wip)
  end

  def close(task)
    log.info text_for(task, :closed)
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

  def text_for(task, status)
    "#{username}, #{task}, #{status.to_s}"
  end

  def username
    `git config user.name`.strip
  end

  def log
    @log ||= Logging.logger[self]
  end



end
