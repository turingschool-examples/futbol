require_relative 'game'
require 'CSV'

class GameCollection
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    csv = CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map { |row| Game.new(row) }
  end

  def avg_goals_per_game
    goals = @games.reduce(0) do |total_goals, game|
      total_goals += (game.away_goals + game.home_goals)
    end
    (goals.to_f / @games.length).round(2)
  end
end
