require './lib/stats'
require_relative 'groupable'

class GameStats < Stats
  include Groupable
  attr_reader :tracker

  def initialize(tracker)
    @tracker = tracker
    super(game_stats_data, game_teams_stats_data, teams_stats_data)
  end

  def total_games
    @game_stats_data.count
  end

  def get_all_scores_by_game_id
    @game_stats_data.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def highest_total_score
    get_all_scores_by_game_id.max
  end

  def lowest_total_score
    get_all_scores_by_game_id.min
  end

  def all_home_wins
    @tracker.league_stats.all_home_wins
  end

  def percentage_home_wins
    (all_home_wins.count.to_f / total_games).round(2)
  end

  def all_visitor_wins
    @tracker.league_stats.all_visitor_wins
  end

  def percentage_visitor_wins
    (all_visitor_wins.count.to_f / total_games).round(2)
  end

  def count_of_ties
    @tracker.league_stats.count_of_ties
  end

  def percentage_ties
    (count_of_ties.to_f / total_games).round(2)
  end

  def hash_of_seasons
    @game_stats_data.group_by {|game| game.season}
  end

  def count_of_games_by_season
    hash = {}
    hash_of_seasons.each do |key, value|
      hash[key.to_s] = value.count
    end
    hash
  end

  def average_goals_per_game
    (get_all_scores_by_game_id.sum / total_games.to_f).round(2)
  end

  def average_goals_by_season
    hash = {}
    hash_of_seasons.each do |season, stat|
      goals_per_season = stat.map do |game|
        game.home_goals + game.away_goals
      end
      hash[season.to_s] = (goals_per_season.sum / stat.count.to_f).round(2)
    end
    hash
  end

  def find_all_game_ids_by_team(team_id)
    @game_stats_data.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
  end
end
