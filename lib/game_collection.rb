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

  def highest_total_score
    highest_total = @games.max_by{ |game| game.away_goals + game.home_goals }
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = @games.min_by{ |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

  def biggest_blowout
    blowout = @games.max_by { |game| (game.home_goals - game.away_goals).abs }
    (blowout.home_goals - blowout.away_goals).abs
  end

  def avg_goals_per_game
    goals = @games.reduce(0) do |total_goals, game|
      total_goals += (game.away_goals + game.home_goals)
    end
    (goals.to_f / @games.length).round(2)
  end
end
