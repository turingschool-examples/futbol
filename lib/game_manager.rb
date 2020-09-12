require 'csv'

class GameManager
  attr_reader :games,
              :tracker
  def initialize(path, tracker)
    @games = []
    create_underscore_games(path)
    @tracker = tracker
  end

  def create_underscore_games(path)
    games_data = CSV.read(path, headers: true)
    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end
  
  def highest_total_score
    highest_score = @games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    highest_score.away_goals.to_i + highest_score.home_goals.to_i
  end
end
