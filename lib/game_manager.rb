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
end
