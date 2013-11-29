require 'spec_helper'

describe Ilpomodoro::PivotalTracker do
  let(:pivotal_tracker){ Ilpomodoro::PivotalTracker.new }
  let(:pivotal_task){ PivotalTracker::Story.new( name: 'a task') }
  let(:pivotal_tasks){ [pivotal_task] }
  let(:pivotal_project){ PivotalTracker::Project.new( name: 'a project') }
  let(:pivotal_projects){ [pivotal_project] }

  it '.init' do
      Ilpomodoro::PivotalTracker.tap do |klass|
        klass.should_receive(:login)
        klass.should_receive(:choose_from_services)
        klass.should_receive(:choose_from_projects)
      end
      Ilpomodoro::PivotalTracker.init
  end

  it '.login' do
    pivotal_tracker.should_receive(:ask).and_return('a username', 'a password')
    PivotalTracker::Client.should_receive(:token).with('a username', 'a password')
    pivotal_tracker.login
  end

  it '.services' do
    pivotal_tracker.services.should == ['pivotaltracker']
  end

  it '.tasks' do
    Ilpomodoro::PivotalTracker.stub(project: stub(stories: stub(all: pivotal_tasks)))
    pivotal_tracker.tasks.should == pivotal_tasks
  end
  it '.projects' do
    PivotalTracker::Project.should_receive(:all).and_return(pivotal_projects)
    pivotal_tracker.projects.should == pivotal_projects
  end

  describe '.choose_from_services' do
    it 'display the options' do
    pivotal_tracker.should_receive :choose
    pivotal_tracker.choose_from_services
    end

    it 'saves into a class variable the choosen project' do
      pivotal_tracker.should_receive(:choose).and_return('the project')
      expect do
        pivotal_tracker.choose_from_projects
      end.to change{Ilpomodoro::PivotalTracker.project }.from(nil).to('the project')
    end

    it 'saves into a class variable the choosen service' do
      pivotal_tracker.should_receive(:choose).and_return('pivotaltracker')
      expect do
        pivotal_tracker.choose_from_services
      end.to change{pivotal_tracker.service }.from(nil).to('pivotaltracker')
    end
  end

  it '.choose_from_projects' do
    pivotal_tracker.should_receive :choose
    pivotal_tracker.choose_from_projects
  end
end
