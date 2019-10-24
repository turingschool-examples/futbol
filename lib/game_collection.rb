require 'csv'
require './lib/game'
require './lib/stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(game_path)
    @game_path = game_path
    @game_instances = all_games
  end

  def all_games
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       Game.new(row)
    end
  end

  def count_of_games_by_season
    season_key_maker
    season_count = {}
    @keys.each do |key|
      season_count[key] = value_maker(key)
    end
    season_count
  end

  def season_key_maker
    @keys = []
    @game_instances.each do |game|
      @keys << game.season
    end
    @keys = @keys.uniq
  end

  def value_maker(season)
    values = []
    @game_instances.each do |game|
      if game.season == season
        values << game
      end
    end
    values
  end

  # Returns an array that contains every game score both winners and losers added together
    def total_scores
      total_scores_array = []
        @game_instances.each do |game|
          total_goals = game.away_goals + game.home_goals
          total_scores_array << total_goals
        end
      total_scores_array
    end

  # Returns the sum of both teams score for the highest scoring game
    def highest_total_score
      total_scores.uniq.max
    end

  # Returns the sum of both teams score for the lowest scoring game
    def lowest_total_score
      total_scores.uniq.min
    end

  # Returns the biggest blowout difference between scores
    def biggest_blowout
      difference = @game_instances.map do |game|
        (game.away_goals - game.home_goals).abs
      end
      difference.uniq.max
    end

  def average_goals_per_game
    home_goals = @game_instances.sum { |game| game.home_goals }
    away_goals = @game_instances.sum { |game| game.away_goals }
    total_games = @game_instances.size
    average_goals_per_game = (home_goals + away_goals) / total_games
  end

  def ave_goals_per_season_values(season)
    goal_array = []
    @game_instances.each do |game|
      if game.season.to_i == season
        goal_array <<  game.away_goals.to_f
        goal_array << game.home_goals.to_f
      end
    end
    (goal_array.sum / goal_array.size).round(2)
  end

  def average_goals_per_season
    ave_goals_per_season = {}
    season_key_maker
    @keys.each do |key|
      ave_goals_per_season[key.to_i] = ave_goals_per_season_values(key.to_i)
    end
    ave_goals_per_season
  end
end
