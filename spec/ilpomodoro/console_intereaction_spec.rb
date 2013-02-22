require 'spec_helper'

describe Ilpomodoro::ConsoleInteraction do
  class DummyClass
    include Ilpomodoro::ConsoleInteraction
  end

  let(:console_interaction){ DummyClass.new }
  
  describe '.get_pivotal_tracker' do
    it 'ask if it uses that service' do
      console_interaction.should_receive(:agree)
        .with('Do you have tasks in pivotaltracker?')
      console_interaction.get_pivotal_params
    end
      
    describe 'when has_pivotaltracker?:true' do
      before do
        console_interaction.should_receive(:has_pivotaltracker?).and_return(true)
        console_interaction.stub(:ask)
      end

      it 'asks for the username and password' do
        console_interaction.should_receive(:ask)
          .with('enter your pivotaltracker username:   ')
        console_interaction.should_receive(:ask)
          .with('enter your pivotaltracker password:   ')
        console_interaction.get_pivotal_params
      end
     
      it 'looks up for available projects' do
        pending
        console_interactive.should_receive(:choose_from_project)
          
        console_interaction.get_pivotal_params
      end

      it 'looks up for available projects' do
        console_interaction
        console_interaction.get_pivotal_params
      end
    end
      
  end
end
