
class Ilpomodoro::Timer
  @notifier = -> message { `terminal-notifier -message '#{message}'`}

  
  class << self
    def do_a(action)
      @notifier.call("#{action} has started")
      progress( time_for(action))
      @notifier.call("#{action} has finished")
    end
    
    private

    def progress(time, number_of_updates = 40)
      duration = 1.0 * time / number_of_updates
      progress_bar = ''

      # pacman = "\u1F47B"
      # chost  = "\u15E3"
      # dot    = "\u00B7"
      # circle = "\u25CF"
      0.upto(number_of_updates) do |i|
          percentage = (i * 1.0 / number_of_updates * 100).to_i
          progress_bar << '|' << '==' * i << '  ' * (number_of_updates - i) << "| #{percentage}%\r"

              print progress_bar
          $stdout.flush

          sleep duration
      end
    end

    def time_for(action) 
      case action
        when :long_break
          15 * 60
        when :short_break
          5 * 60
        when :pomodoro
          25 * 60
      end
    end
  end
end

