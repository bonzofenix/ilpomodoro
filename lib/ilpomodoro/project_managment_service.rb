class Ilpomodoro::ProjectManagmentService
  def initialize(user, password)
    @user = user
    @password = password
  end


  def choose_from_available_projects
    choose do |m|
      m.prompt = 'in which project you will be working on?'
      projects.each do |p|
        m.choice p
      end
    end
  end

  def projects
      ['projecto a', 'projecto b']
  end
end
