require_relative './game_collection'
require 'CSV'

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  attr_reader :game_stats, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_stats = GameCollection.new(game_path)
    @team_path = team_path
    @game_team_path = game_team_path
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def biggest_blowout
    @game_stats.biggest_blowout
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season(season)
    @game_stats.length == season
  end

  def average_goals_per_game
    total_goals = @game_stats.map { |game| game.total_score }
    (total_goals.sum.to_f / @game_stats.length).round(2)
  end

  def average_goals_by_season(season)
    game_count = @game_stats.length == season
    (game_count.to_f / @game_stats.length).round(2)
  end

end
