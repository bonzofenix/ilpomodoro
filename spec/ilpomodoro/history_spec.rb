require 'spec_helper'

describe Ilpomodoro::History do
  let(:history){ Ilpomodoro::History.new }
  let(:log_output){ @log_output.sio.string }

  describe 'when writting log' do
    before do
      history.stub(username: 'bonzofenix')
    end

    it 'logs a wip task' do
      history.wip('this task has not been finished yet' )
      log_output.should =~ /bonzofenix, this task has not been finished yet, wip/
    end

    it 'logs a started task' do
      history.start('this task has just start' )
      log_output.should =~ /bonzofenix, this task has just start, start/
    end

    it 'logs a close task' do
      history.close('this task has been closed' )
      log_output.should =~ /bonzofenix, this task has been closed, closed/
    end
  end

  describe 'when creating logging files' do
    it 'creates the file in the users folder' do
      history.get_appenders.length.should == 2
    end
  end
end

