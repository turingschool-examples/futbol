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

  def percentage_home_wins
    home_wins = @games.find_all do |game|
      game.home_goals > game.away_goals
    end
    ((home_wins.length.to_f / @games.length.to_f) * 100).round(2)
  end

  def percentage_away_wins
    away_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end
    ((away_wins.length.to_f / @games.length.to_f) * 100).round(2)
  end

end
