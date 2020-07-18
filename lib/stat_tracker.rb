require "CSV"
require "./lib/games"

class StatTracker
  attr_reader :games

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    # @teams = locations[:teams]
    # @game_teams = locations[:game_teams]
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
    # require "pry"; binding.pry
  end

  def highest_total_score
    output = @games.max_by do |game|
      game.total_game_score
    end
    output.total_game_score
  end
end
