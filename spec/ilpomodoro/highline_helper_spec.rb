require 'spec_helper'

describe Ilpomodoro::HighlineHelper do
  
  let(:test_class) do 
    @class = Class.new
    @class.send(:include, Ilpomodoro::HighlineHelper)
  end

  let(:test_object) do
    @object = test_class.new
  end

  describe 'class with included HighlineHelper' do

    it 'has #highline instance and class methods' do
      expect(test_class.respond_to?(:highline)).to be true
      expect(test_class.highline).to be_a HighLine
      expect(test_object.respond_to?(:highline)).to be true
      expect(test_object.highline).to be_a HighLine
    end


    it 'has highline instance methods' do
      %i(ask choose).each do |method_name|
        expect(test_object.respond_to?(method_name)).to be true
      end
    end

    it 'has highline class methods' do
      %i(ask choose).each do |method_name|
        expect(test_class.respond_to?(method_name)).to be true
      end
    end

  end

end

