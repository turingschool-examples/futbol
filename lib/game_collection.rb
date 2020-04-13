require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games_list

  def initialize(file_path)
    @games_list = create_games(file_path)
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  # percentage_home_wins Percentage of games that a home team has won (rounded to the nearest 100th)Float

  def percentage_home_wins
    percentage(home_wins.to_f / @games_list.length.to_f)
  end

  def percentage_visitor_wins
    percentage(away_wins.to_f / @games_list.length.to_f)
  end

  def percentage_ties
    percentage(ties.to_f / @games_list.length.to_f)
  end

  def count_of_games_by_season
    @games_list.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    # (total_scores.sum.to_f / @games_list.length.to_f).round(2)
    average2(total_scores, games_list)
  end

  def average_goals_by_season
    # count_of_games_by_season.transform_values! do |games|
    #   average(total_scores)


  end

  # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)

  # helper methods

  def percentage(collection)
    (collection).round(2)
  end

  def average(collection)
    (collection.sum / collection.length.to_f).round(2)
  end

  def average2(collection1, collection2)
    (collection1.sum / collection2.length.to_f).round(2)
  end

  def total_scores
    @games_list.map { |game| game.home_goals.to_i + game.away_goals.to_i }
  end

  def home_wins
    # tying to find all the home wins
    @games_list.select { |game| game.home_goals > game.away_goals}.length
  end

  def away_wins
    @games_list.select { |game| game.home_goals < game.away_goals}.length
  end

  def ties
    @games_list.select { |game| game.home_goals == game.away_goals}.length
  end

  def get_games_of_season(season)
    @game_stats.game_stats.find_all do |game|
      game.game_id.to_s[0..3] == season[0..3]
    end
  end

end
