require 'spec_helper'

describe Ilpomodoro::ProjectManagement do
  let(:project_management){ Ilpomodoro::ProjectManagement }
  let(:pivotal_task){ PivotalTracker::Story.new( name: 'a task') }
  let(:pivotal_tasks){ [pivotal_task] }
  let(:pivotal_project){ PivotalTracker::Project.new( name: 'a project') }
  let(:pivotal_projects){ [pivotal_project] }
  it '.init' do
      Ilpomodoro::ProjectManagement.tap do |klass|
        klass.should_receive(:login)
        klass.should_receive(:choose_from_services)
        klass.should_receive(:choose_from_projects)
      end
      Ilpomodoro::ProjectManagement.init
  end

  it '.login' do
    project_management.should_receive(:ask).and_return('a username', 'a password')
    PivotalTracker::Client.should_receive(:token).with('a username', 'a password')
    project_management.login
  end

  it '.services' do
    project_management.services.should == ['pivotaltracker']
  end

  it '.tasks' do
    Ilpomodoro::ProjectManagement.stub(project: stub(stories: stub(all: pivotal_tasks)))
    project_management.tasks.should == pivotal_tasks
  end
  it '.projects' do
    PivotalTracker::Project.should_receive(:all).and_return(pivotal_projects)
    project_management.projects.should == pivotal_projects
  end

  describe '.choose_from_services' do
    it 'display the options' do
    project_management.should_receive :choose
    project_management.choose_from_services
    end

    it 'saves into a class variable the choosen project' do
      project_management.should_receive(:choose).and_return('the project')
      expect do
        project_management.choose_from_projects
      end.to change{Ilpomodoro::ProjectManagement.project }.from(nil).to('the project')
    end

    it 'saves into a class variable the choosen service' do
      project_management.should_receive(:choose).and_return('pivotaltracker')
      expect do
        project_management.choose_from_services
      end.to change{project_management.service }.from(nil).to('pivotaltracker')
    end
  end

  it '.choose_from_projects' do
    project_management.should_receive :choose
    project_management.choose_from_projects
  end
end
