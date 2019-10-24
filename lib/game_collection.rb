require 'csv'
require './lib/game'
require './lib/stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(game_path)
    @game_path = game_path
    all_games
  end

  def all_games
    @game_instances = []
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      @game_instances <<  Game.new(row)
    end
    @game_instances
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
