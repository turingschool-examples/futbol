require_relative './game'
require_relative './averageable'

class GamesManager
  include Averageable
  attr_reader :games, :tracker
  def initialize(games_path, tracker)
    @games = []
    @tracker = tracker
    create_games(games_path)
  end

  def create_games(games_path)
    games_data = CSV.parse(File.read(games_path), headers: true)
    @games = games_data.map do |data|
      Game.new(data, self)
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
    home_games_won = @games.count do |game|
      game.home_goals > game.away_goals
    end.to_f
    average_with_count(home_games_won, @games, 2)
  end

  def percentage_visitor_wins
    visitor_games_won = @games.count do |game|
      game.home_goals < game.away_goals
    end
    (visitor_games_won.to_f / @games.count).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties.to_f / @games.count).round(2)
  end

  def list_of_seasons
    @games.map do |game|
      game.season
    end.uniq
  end

  def count_games_by_season
    games_per_season = {}
    list_of_seasons.each do |season|
      games_per_season[season] = @games.count do |game|
        game.season == season
      end
    end
    games_per_season
  end

  def total_goals
    @games.sum do |game|
      game.total_score
    end
  end

  def average_goals_per_game
    (total_goals.to_f / @games.count).round(2)
  end

  def total_goals_by_season(season)
    @games.sum do |game|
      if game.season == season
        game.total_score
      else
        0
      end
    end
  end

  def average_goals_by_season_data(season)
    (total_goals_by_season(season) / count_games_by_season[season].to_f).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = {}
    list_of_seasons.each do |season|
      average_goals_by_season[season] = average_goals_by_season_data(season)
    end
    average_goals_by_season
  end

  def find_season_id(game_id)
    @games.find do |game|
      game.game_id == game_id
    end.season
  end
end
