require_relative './game'

class GamesManager
  attr_reader :data_path, :games

  def initialize(data_path)
    @games = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Game.new(row)
    end
    list_of_data
  end

  def highest_total_score
    total_scores = games.map do |game|
      game.away_goals + game.home_goals
    end.max
  end

  def lowest_total_score
    total_scores = games.map do |game|
      game.away_goals + game.home_goals
    end.min
  end
end
