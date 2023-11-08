require 'CSV'
require_relative './game'

class StatTracker
  attr_reader :game_teams

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
    fewest_goals = @games.map{|game| game.home_goals + game.away_goals}
    fewest_goals = fewest_goals.min
  end

  def percentage_home_wins
    home_win_count = @game_teams.count do |game|
      game.hoa == "home" && game.result == "WIN"
    end
    home_win_count.fdiv(@game_teams.count / 2).round(2)
  end

  def percentage_visitor_wins
    visitor_win_count = @game_teams.count do |game|
      game.hoa == "away" && game.result == "WIN"
    end
    visitor_win_count.fdiv(@game_teams.count / 2).round(2)
  end

  def percentage_ties
    tie_count = @game_teams.count do |game|
      game.hoa == "away" && game.result == "TIE"
    end
    tie_count.fdiv(@game_teams.count / 2).round(2)
  end
end
