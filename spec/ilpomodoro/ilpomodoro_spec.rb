require 'spec_helper'

describe Ilpomodoro do

  include Cancun::Highline

  before do
    init_cancun_highline
  end
  let(:ilpomodoro) { described_class.new }

  it 'work offline' do
  end

  describe 'when working offline' do
    before do
      execute do
        ilpomodoro.work_offline?
      end.and_type "y", 'a new task'
    end

    it 'returns true' do
      expect(ilpomodoro.work_offline?).to eq(true)
    end

    it 'ask correctly' do
      expect(output).to include('do you want to work offline?')
    end

    it 'should return an offline task' do
      expect(ilpomodoro.task).to eq('a new task')
    end
  end

  describe 'when working online' do
    before do
      #TODO: add vcr
      execute do
        ilpomodoro.work_offline?
      end.and_type "n"
    end
    pending 'returns a task from pivotal tracker'
  end
end
