class FenixPomodoro
  def start
    HistoryManager.prompt
  end
end

Dir["{lib}/fenix_pomodoro/**/*.rb"].each { |path| require_relative path.gsub('lib/','') }


require 'highline/import'
