require 'csv'
require_relative './game'
require_relative './teams'
require_relative './game_teams'

class StatTracker
  attr_reader :game_teams

  def initialize
    @games = Game.create_games
    @teams = Teams.create_teams
    @game_teams = GameTeams.create_game_teams
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new
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

  def count_of_games_by_season
    season_game_count = Hash.new(0)
    @games.each do |game|
      season_game_count[game.season] += 1
    end
    season_game_count
  end

  def average_goals_per_game
    games = @games.sum do |game|
      game.home_goals + game.away_goals
    end
    games.fdiv(@games.count).round(2)
  end

  def total_goals(game)
    game.home_goals + game.away_goals
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    @games.each do |game|
      goals_by_season[game.season] += total_goals(game)
    end
    average_goals = goals_by_season.map do |season, total_goals|
      total_goals.fdiv(count_of_games_by_season[season])
    end
    average_goals.each do |goals|
      goals_by_season.each do |season, total_goals|
        goals_by_season[season] = goals.round(2)
      end
    end
    goals_by_season
  end

  def lowest_scoring_visitor
    @game_teams.min_by {|game_team| game_team.hoa == "away" }
  end
end
