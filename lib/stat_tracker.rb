require 'csv'

class StatTracker
  def self.from_csv(file_path)
    StatTracker.new
    games_csv = CSV.read("#{file_path[:games]}", headers: true, header_converters: :symbol)
    teams_csv = CSV.read("#{file_path[:teams]}", headers: true, header_converters: :symbol)
    game_teams_csv = CSV.read("#{file_path[:game_teams]}", headers: true, header_converters: :symbol)
  end
end
