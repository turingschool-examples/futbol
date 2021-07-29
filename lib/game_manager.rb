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

  def total_games
    @games.count
  end

  def home_wins_count
    @games.count do |game|
      game.home_goals > game.away_goals
    end
  end

  def percent_home_wins
    (home_wins_count.to_f / total_games * 100).round(1)
  end

  def visitor_wins_count
    @games.count do |game|
      game.away_goals > game.home_goals
    end
  end

  def percent_visitor_wins
    (visitor_wins_count.to_f / total_games * 100).round(1)
  end

  def tie_count
    total_games - (home_wins_count + visitor_wins_count)
  end

  def percent_ties
    (tie_count.to_f / total_games * 100).round(1)
  end

  def games_by_season
    @games.group_by do |game|
      game.season
    end
  end
end






  # def array_of_seasons
  #   @games.map do |game|
  #     game.season
  #   end.uniq
  # end
