require 'spec_helper'

describe Ilpomodoro do
  let(:ilpomodoro){ Ilpomodoro.new }
  let(:pivotal_params){ {username: 'bonzofenix', password: 'password'}}

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
end
