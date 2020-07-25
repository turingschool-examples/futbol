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

  def create_games_by_season_array
    games_by_season = {}
    @games_array.each do |game|
      games_by_season[game.season] = []
    end
    @games_array.each do |game|
      games_by_season[game.season]<< game.game_id
    end
    games_by_season
  end

  def count_of_games_by_season(games_by_season)
    games_by_season.each { |k, v| games_by_season[k] = v.count}
  end

  def collect_all_goals
    total_goals = []
    @games_array.each do |game|
      total_goals << game.away_goals.to_i
      total_goals << game.home_goals.to_i
    end
    total_goals
  end

  def average_goals_per_game(total_goals)
    (total_goals.sum.to_f/(total_goals.size/2)).round(2)
  end


  end
