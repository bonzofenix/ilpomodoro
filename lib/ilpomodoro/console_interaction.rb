class Ilpomodoro
module ConsoleInteraction
  def get_task
    ask('in this pomodoro i will be working on...')
  end
  
  def finished?(task) 
    agree("have you finish #{task}?(y/n)")
  end

  def was_doing_code?
    agree("have you been doing code?(y/n)")
  end

  def wants_to_commit?
    agree("do you want to commit?(y/n)")
  end

  def logging_to_project_manager
    username = get_username('pivotaltracker')
    password =  get_password('pivotaltracker')
    ProjectManagmentService.new(username, password)
  end


  def get_pivotal_params
    return unless has_pivotaltracker?
    pm = logging_to_project_manager
    pm.choose_from_available_projects
  end

  private
  def get_username(service = '')
    ask("enter your #{service} username:   ")
  end
  
  def get_password(service = '')
    ask("enter your #{service} password:   "){ |q| q.echo = 'x' } 
  end

  def has_pivotaltracker?
    agree('Do you have tasks in pivotaltracker?')
  end
end
end
