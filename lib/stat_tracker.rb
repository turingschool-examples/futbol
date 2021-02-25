require './lib/game'
require './lib/team'
require './lib/game_team'
require_relative 'csv_loadable'

class StatTracker
  include CsvLoadable

  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(locations)
    game_teams_path = locations[:game_teams]
    games_path      = locations[:games]
    teams_path      = locations[:teams]
    StatTracker.new(game_teams_path, games_path, teams_path)
  end

  def initialize(game_teams_path, game_path, teams_path)
    @games      = load_csv_data(game_path, Game)
    @teams      = load_csv_data(teams_path, Team)
    @game_teams = load_csv_data(game_teams_path, GameTeam)
  end

  def highest_total_score
    scores = @games.flat_map do |game|
      [game.away_goals.to_i + game.home_goals.to_i]
    end
    scores.max
  end
end
