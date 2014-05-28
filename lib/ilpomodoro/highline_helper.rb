require 'forwardable'
require 'highline'

module Ilpomodoro::HighlineHelper
  
  module ClassMethods
    extend Forwardable
    def_delegators(:highline, :ask, :choose)
    def highline
      @highline ||= HighLine.new
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
    base.extend(Forwardable)
    base.def_delegators(:highline, :ask, :choose)
  end

  def highline
    self.class.highline
  end

end
