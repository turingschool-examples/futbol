require 'CSV'
class StatTracker
  attr_reader :games, :teams, :game_stats

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_stats = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_stats)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_stats = game_teams_path
    require "pry"; binding.pry
  end

end
