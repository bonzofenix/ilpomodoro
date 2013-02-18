class Ilpomodoro::Historm
  attr_accessor :current_task

  def initialize
    @log = get_logger
  end

  def add_task(task)
    @current_task = task
  end
  
  def add_or_create(task)
    task ||= create_task 
    add_task(task) 
  end
  
  def close_task(task)
    @current_task = nil
  end

  def create_task
    ask('in this pomodoro i will be working on...')
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
