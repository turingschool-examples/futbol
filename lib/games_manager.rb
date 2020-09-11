require 'csv'
require_relative './stat_tracker'
require_relative './game'

class GamesManager

  attr_reader :stat_tracker, :games

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @games = []
    create_games(path)
  end

  def create_games(games_table)
    @games = games_table.map do |data|
      Game.new(data)
    end
  end


  # move to GameManager call on score sum for each game
  # maybe remove season filter?
  # add method in game class that sums total game score
  def sum_game_goals
    game_goals_hash = {}
    @games.each do |game|
      #sum all sum_score
      game_goals_hash[game.game_id] = (game.away_goals + game.home_goals)
    end
    game_goals_hash
  end

  def lowest_total_score
    sum_game_goals.min_by do |game_id, score|
      score
    end.last
  end

end
