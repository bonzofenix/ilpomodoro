require 'spec_helper'

describe Ilpomodoro::History do
  describe 'Rails.root' do
    it '' do
      Rails.root.should be_kind_of(Pathname)
    end

    it 'points to the dummy rails app folder' do
      Rails.root.to_s.should == 'spec/dummy/'
    end
  end

  it 'creates the .ilpomodoro file' do
    Ilpomodoro::History.new
    File.exists?(Rails.root.join('.ilpomodoro')).should be_true
  end
end

