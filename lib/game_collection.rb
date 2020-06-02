require_relative 'loadable'
require_relative 'game'

class GameCollection
  include Loadable

  attr_reader :games_array

  def initialize(file_path)
    @games_array = create_games_array(file_path)
  end

  def create_games_array(file_path)
    load_from_csv(file_path, Game)
  end

  def sum_of_game_goals_list
    @games_array.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
  end

  def highest_total_score
    sum_of_game_goals_list.max
  end

  def lowest_total_score
    sum_of_game_goals_list.min
  end

  def home_wins
    home_wins = []
    @games_array.each do |game|
      home_wins << game.game_id if game.home_goals > game.away_goals
    end
    home_wins
  end

  def away_wins
    away_wins = []
    @games_array.each do |game|
      away_wins << game.game_id if game.home_goals < game.away_goals
    end
    away_wins
  end

  def ties
    ties = []
    @games_array.each do |game|
      ties << game.game_id if game.home_goals == game.away_goals
    end
    ties
  end

  def percentage_home_wins
    percent = home_wins.count.to_f / @games_array.count.to_f * 100
    percent.round(2)
  end

  def percentage_visitor_wins
    percent = away_wins.count.to_f / @games_array.count.to_f * 100
    percent.round(2)
  end

  def percentage_ties
    percentage = ties.count.to_f / @games_array.count.to_f * 100
    percentage.round(2)
  end

  def games_by_season
    games_by_season = @games_array.group_by do |game|
      game.season
    end
  end

  def count_of_games_by_season
    games_by_season.transform_values do |game|
      game.length
    end
  end

  def average_goals_per_game
    average = sum_of_game_goals_list.sum / (@games_array.count * 2).to_f
    average.round(2)
  end

  def average_goals_by_season
    games_by_season.transform_values do |values|
      sum_total_score = 0
      values.each do |game|
        sum_total_score += game.away_goals.to_i + game.home_goals.to_i
      end
      average_goals_per_season = sum_total_score / (values.count * 2).to_f
      average_goals_per_season.round(2)
    end
  end
end
