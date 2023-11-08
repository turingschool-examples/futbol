require 'CSV'
require_relative './game'

class StatTracker

  def initialize
    @games = Game.create_games
    @teams = Teams.create_teams
    @game_teams = GameTeams.create_game_teams
  end

  def highest_total_score
    most_goals = @games.max_by{|game| game.home_goals + game.away_goals}
    most_goals = most_goals.home_goals + most_goals.away_goals
  end

  def lowest_total_score
    fewest_goals = @games.min_by{|game| game.home_goals + game.away_goals}
    fewest_goals = fewest_goals.home_goals + fewest_goals.away_goals
  end
end
