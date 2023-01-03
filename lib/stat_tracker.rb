require 'CSV'

class StatTracker
  # attr_reader   
             
  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_teams = game_teams_path
  end

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end
end     




