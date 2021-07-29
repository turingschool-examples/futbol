require 'game'

class GameManager
  attr_reader :games,
              :season_hash

  def initialize(locations)
    @games = Game.read_file(locations[:games])
    @season_hash = {}
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

  # def seasons
  #   @games.map do |game|
  #     game.season
  #   end.uniq
  # @games.group_by do |game|
  #   game.season
  # end

  def games_per_season

    @games.each do |game|
      @season_hash[game.season] ||= []
      @season_hash[game.season] << game
    end
    @season_hash
  end

  def count_of_games_by_season
    game_count = {}
    games_per_season.each do |season, game|
      game_count[season] = game.count
    end
  end
  # def count_of_teams_per_season
  #   @season_hash = {}
  #   @games.each do |game|
  #     game.season

  #   @games.find_all do |game|
  #     game_count = game.count
  #     season_hash[game.season] ||= []
  #     season_hash[game.season] << game_count
  #   end
  # end
end






  # def array_of_seasons
  #   @games.map do |game|
  #     game.season
  #   end.uniq
  # end
