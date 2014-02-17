require 'spec_helper'

describe Ilpomodoro do
  describe '.start' do
    before{ ilpomodoro.stub(:loop) }

    it 'do the loop!' do
      ilpomodoro.should_receive(:loop)
      ilpomodoro.start
    end
  end
end
