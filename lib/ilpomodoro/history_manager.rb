module Ilpomodoro::HistoryManager
  class << self
    def prompt
      what_you_did = ask('what you did in this pomodoro?')
      puts what_you_did
    end
  end
end
