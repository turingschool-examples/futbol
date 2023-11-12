require 'CSV'
require_relative './game'

class GameList
  attr_reader :games, :stat_tracker

  def initialize(path, stat_tracker)
    @games = create_games(path)
    @stat_tracker = stat_tracker
  end

  def create_games(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |datum|
      Game.new(datum, self)
    end
  end

  def highest_total_score
    @games.max_by do |game|
      game.total_score
    end.total_score
  end

  def lowest_total_score
    @games.min_by do |game|
      game.total_score
    end.total_score
  end

  def percentage_home_wins
    home_wins = Hash.new(0)

    @games.each do |game|
      home_wins[game.home_goals] += 1 if game.home_goals > game.away_goals
    end
    home_wins.values.sum / @games.length.to_f
  end
  
  # Can we pull the results from the percentages to a helper method?
  def percentage_home_wins
    home_wins = Hash.new(0)

    @games.each do |game|
      home_wins[game.home_goals] += 1 if game.home_goals > game.away_goals
    end
    result = home_wins.values.sum.to_f / @games.length.to_f
    result.ceil(2)
  end

  def percentage_visitor_wins
    visitor_wins = Hash.new(0)

    @games.each do |game|
      visitor_wins[game.away_goals] += 1 if game.away_goals > game.home_goals
    end
    result = visitor_wins.values.sum.to_f / @games.length.to_f
    result.ceil(2)
  end
  
  def percentage_ties
    ties = Hash.new(0)

    @games.each do |game|
      ties[game.home_goals] += 1 if game.home_goals == game.away_goals
    end
    result = ties.values.sum.to_f / @games.length.to_f
    result.ceil(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.map do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

end