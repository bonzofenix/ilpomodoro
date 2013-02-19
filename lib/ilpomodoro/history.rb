class Ilpomodoro::History
  attr_accessor :current_task

  def initialize
    @log = get_logger
  end
  
  def wip(task)
    @log.info(task, :wip)
  end
  
  def start_session
  end

  def close(task)
    @log.info(task, :close)
  end

  
  private

  def get_logger
    Logging.logger.tap do |l|
      l.root.level = :info
      l.root.appenders = Logging.appenders.file(loggging_file_path) 
    end
  end
  
  def loggging_file_path
    Rails.root.join('.ilpomodoro')
  end
end
