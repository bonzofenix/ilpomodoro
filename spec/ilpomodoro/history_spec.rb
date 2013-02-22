require 'spec_helper'

describe Ilpomodoro::History do
  let(:history){ Ilpomodoro::History.new }
  let(:log_output){ @log_output.sio.string }

  describe 'when writting log' do
    it 'logs a wip task' do
      history.wip('this task has not been finished yet' )
      log_output.should =~ /this task has not been finished yet, wip/
    end
      
    it 'logs a started task' do
      history.start('this task has just start' )
      log_output.should =~ /this task has just start, start/
    end

    it 'logs a close task' do
      history.close('this task has been closed' )
      log_output.should =~ /this task has been closed, closed/
    end
  end
    
  describe 'when creating logging files' do
    before{ history }

    it 'creates the file in the root of the project' do
      pending
      history.get_appenders.count.should == 2
    end

    it 'creates the file in the users folder' do
      history.get_appenders.count.should == 1
    end
  end
end

