require_relative './game'

class GamesManager
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
    end
    ((home_games_won.to_f / @games.count) * 100).round(2)
  end

  def percentage_visitor_wins
    visitor_games_won = @games.count do |game|
      game.home_goals < game.away_goals
    end
    ((visitor_games_won.to_f / @games.count) * 100).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.home_goals == game.away_goals
    end
    ((ties.to_f / @games.count) * 100).round(2)
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
end
