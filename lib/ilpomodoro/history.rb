class Ilpomodoro::History
  attr_accessor :current_task
  
  def wip(task)
    log.info text_for(task, :wip)
  end
  
  def close(task)
    log.info text_for(task, :closed)
  end
  
  
  private
  
  def text_for(task, status)
    "#{task}, #{status.to_s}"
  end

  def log
    @log unless @log.nil?
    Logging.tap do |c|
      c.format_as(:yaml)
      c.logger.root.level = :info
      c.logger.root.appenders = c.appenders.file(loggging_file_path) 
      @log = c.logger[self]
    end
    @log
  end
  
  def loggging_file_path
    filename = '.ilpomodoro'
    if Object.const_defined?('Rails')
      Rails.root.join(filename)
    else
      Pathname.new(filename)
    end
  end
end
