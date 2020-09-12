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
    # highest_game = sum_team_scores.max_by { |game_id, score| score }
    # highest_game[1]
  end

end
