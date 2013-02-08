#! /usr/bin/ruby

require 'hashie'

options = ARGV
if options.include?('--help') || options.include?('-h')
  puts "A simple pomodoro timer in ruby."
  puts "Usage:"
  puts "$ ruby pomodoro.rb [--time TIME]"
  puts "TIME: time (in minutes) of a single pomodoro"
  exit
end

pomodoro_time = 25 # minutes
if i = options.index('--time')
  pomodoro_time = options[i+1].to_i
  if pomodoro_time == 0
    puts "Invalid time specified."
    exit(1)
  end
end


@notifier = -> message { `terminal-notifier -message '#{message}'`}


pomodoro = Hashie::Mash.new(name: 'Pomodoro', time: pomodoro_time * 60, messages: {start: 'pomodoro started!', finish: 'Pomodoro Time is up!'})
short_break = Hashie::Mash.new(name: 'Short break', time: 5 * 60, messages: {start: 'take a short break', finish: 'Pomodoro Break is up!'})
long_break = Hashie::Mash.new(name: 'Long break', time: 15 * 60, messages: {start: 'take a 15min break', finish: 'Pomodoro Break is up!'} )

def start(chunk)
  @notifier.call(chunk.messages.start)
  puts "\n#{chunk.name}!"
  puts "started: #{Time.now.strftime('%H:%M')} (duration: #{chunk.time/60}m)"
end

def progress(time, number_of_updates)
  duration = 1.0 * time / number_of_updates
  progress_bar = ''

  0.upto(number_of_updates) do |i|
    percentage = (i * 1.0 / number_of_updates * 100).to_i
    progress_bar << '|' << '==' * i << '  ' * (number_of_updates - i) << "| #{percentage}%\r"

    print progress_bar
    $stdout.flush

    sleep duration
  end
end

def display_stats
  puts "\nYou've completed #{@pomodoro_count} full pomodoros."
  exit 0
end

def long_break_time?
  @pomodoro_count % 4 == 0
end

def finish(chunk)
  @notifier.call(chunk.messages.finish)
end

def run(chunk)
  start(chunk)
  progress(chunk.time, 20)
  finish(chunk)
end

trap('INT') { display_stats }

@pomodoro_count = 0

loop do
  run(pomodoro)
  @pomodoro_count += 1
  long_break_time? ? run(long_break) : run(short_break)
end

