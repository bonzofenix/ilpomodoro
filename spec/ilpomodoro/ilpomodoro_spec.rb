require 'spec_helper'

describe Ilpomodoro do
  let(:ilpomodoro) do
    Ilpomodoro.new
  end
  
  describe '.first_time?' do
    it 'returns false if configuration file exists' do
      `touch .ilpomodoro-config`  
      ilpomodoro.first_time?.should be_false
      `rm .ilpomodoro-config`
    end

    it 'returns true unless configuration file exists' do
      `touch .ilpomodoro-config`  
      `rm .ilpomodoro-config`
      ilpomodoro.first_time?.should be_true
    end
  end

  describe 'choose_from_tasks' do
    it 'looks for managements task' do
      Ilpomodoro::ProjectManagement.should_receive(:tasks)
      ilpomodoro.choose_from_tasks
    end

    it 'displays the possible tasks' do
      ilpomodoro.should_receive(:choose)
      ilpomodoro.choose_from_tasks
    end

    it 'sets the choosen task' do
      ilpomodoro.should_receive(:choose).and_return('a task')
      expect do 
        ilpomodoro.choose_from_tasks
      end.to change{ ilpomodoro.task}.from(nil).to('a task')
    end
  end

  describe '.start' do
    before{ ilpomodoro.stub(:loop) }
    it 'inits the project managemenet servie' do
      ilpomodoro.should_receive(:init_project_management)
      ilpomodoro.start
    end

    it 'do the loop!' do
      pending
      ilpomodoro.should_receive(:loop)
      ilpomodoro.start
    end
  end

  describe '.choose_from_tasks' do
    it 'looks up for available projects' do
      Ilpomodoro::ProjectManagement.tap do |klass|
        klass.should_receive(:login)
        klass.should_receive(:choose_from_services)
        klass.should_receive(:choose_from_projects)
      end

      ilpomodoro.init_project_management
    end
  end
end
