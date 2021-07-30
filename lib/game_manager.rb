require 'game'

class GameManager
  attr_reader :games,
              :season_hash
              :id_hash

  def initialize(locations)
    @games = Game.read_file(locations[:games])
    @season_hash = {}
    @id_hash = {}
  end

  # def game_by_id_hash
  #   @games.map do |game|
  #     if game.game_id
  #       @id_hash[game.game_id] = game
  #     end
  #   end
  #   @id_hash
  # end

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

  def game_by_id(game_id)
    game_return = @games.filter do |game|
      game.game_id
    end
    game_return[0]
  end

  def count_of_games_by_season
    game_count = {}
    games_by_season.each do |k,v|
      game_count[k] = v.count
    end
    game_count
  end

  def games_by_season
    @games.group_by do |game|
      game.season
    end
  end


  def average_goals_per_game
    total_game_score.sum.fdiv(@games.count)
  end

  def average_goals_by_season
    goals_by_season = {}
    games_by_season.map do |season, games|
      sum_of_goals = games.sum do |game|
        game.away_goals.to_f + game.home_goals.to_f
        end
      goals_by_season[season] = sum_of_goals.fdiv(games.count)
    end
    goals_by_season
  end
end
