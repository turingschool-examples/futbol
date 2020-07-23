require './lib/game'

class GameManager
  attr_reader :games_array

  def initialize(game_path)
    @games_array = []
    CSV.foreach(game_path, headers: true) do |row|
      @games_array << Game.new(row)
    end
  end

  def highest_total_score
    @all_goals_max = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_max << total_goals
    end
    @all_goals_max.max
  end

  def lowest_total_score
    @all_goals_min = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_min << total_goals
    end
    @all_goals_min.min
  end

  #
  # def count_of_games_by_season
  #   @games_array.reduce(Hash.new{|hash, key| hash[key] = []}) do |result, game|
  #     game.each do |season|
  #       result[game.season] << game
  #     end
  #     result
  #   end
  #   # @games_array.each do |game|
    #   seasons[game.season] << game
    # end
    # season_count_hash = {}
    # seasons.each do |season_item|
    #   season_count_hash[season_item.season] = season_item.count
    #   require "pry"; binding.pry
    # end
    # season_count_hash


  end
