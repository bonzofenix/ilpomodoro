require 'forwardable'
require 'highline'

HIGHLINE_METHODS = [:ask, :choose, :agree]

module Ilpomodoro::HighlineHelper
  


  module ClassMethods
    extend Forwardable
    def_delegators(:highline, *HIGHLINE_METHODS)
    def highline
      @highline ||= HighLine.new
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
    base.extend(Forwardable)
    base.def_delegators(:highline, *HIGHLINE_METHODS)
  end

  def highline
    self.class.highline
  end

end
