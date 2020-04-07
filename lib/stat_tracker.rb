require 'CSV'
class StatTracker
  attr_reader :games, :teams, :game_stats

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games])
    teams = CSV.read(csv_files[:teams])
    game_stats = CSV.read(csv_files[:game_teams])

    StatTracker.new(games, teams, game_stats)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_stats = game_teams_path
  end

end
