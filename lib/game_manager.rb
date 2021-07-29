require 'game'

class GameManager
  attr_reader :games

  def initialize(locations)
    @games = Game.read_file(locations[:games])
  end

  def total_game_score
    @games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
  end

  def highest_total_score
    total_game_score.max_by do |score|
      score
    end
  end

  def lowest_total_score
    total_game_score.min_by do |score|
      score
    end
  end
end






  # def array_of_seasons
  #   @games.map do |game|
  #     game.season
  #   end.uniq
  # end
