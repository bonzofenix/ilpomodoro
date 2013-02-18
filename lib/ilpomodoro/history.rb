class Ilpomodoro::History
  attr_accessor :current_task


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
end
