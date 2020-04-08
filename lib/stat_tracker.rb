require 'csv'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    GameTeam.from_csv(game_teams_path)
    Team.from_csv(teams_path)

    @games = Game.all
    @teams = Team.all
    @game_teams = GameTeam.all
  end

  def highest_total_score
    highest_scoring_game = @games.max_by do |game| game.away_goals + game.home_goals
    end
    highest_scoring_game.away_goals + highest_scoring_game.home_goals
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game| game.away_goals + game.home_goals
    end
    lowest_scoring_game.away_goals + lowest_scoring_game.home_goals
  end

end
