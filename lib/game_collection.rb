require './lib/game'
require 'csv'

class GameCollection
attr_reader :games

  def create_games(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Game.new(row)
    end
  end

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game.home_goals + game.away_goals
    end
    highest_scoring_game
    require "pry"; binding.pry
  end
end


  #

# count_of_games_by_season	A hash with season names (e.g. 20122013) as keys and counts of games as values	Hash
# average_goals_per_game	Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)	Float
# average_goals_by_season	Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as a key (rounded to the nearest 100th)
