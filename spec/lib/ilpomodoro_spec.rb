require 'spec_helper'

describe Ilpomodoro do
  let(:ilpomodoro) do
    described_class.new
  end

  before do
    Ilpomodoro::ProjectManagement.stub(:init)
  end

  describe 'choose_from_tasks' do
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

  describe '.new' do
    it 'inits the project managemenet servie' do
      Ilpomodoro::ProjectManagement.should_receive :init
      described_class.new
    end
  end

  describe '.start' do
    before{ ilpomodoro.stub(:loop) }

    it 'do the loop!' do
      ilpomodoro.should_receive(:loop)
      ilpomodoro.start
    end
  end
end
