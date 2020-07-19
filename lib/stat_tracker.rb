require "CSV"
require "./lib/game"
require "./lib/teams"
## => Arique's set up
class StatTracker
  attr_reader :games, :teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    # @teams = locations[:teams]
    # @game_teams = locations[:game_teams]
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end



  def highest_total_score
    output = @games.max_by do |game|
      game.total_game_score
    end
    output.total_game_score
  end
end

# require "CSV"
# require_relative "./game"

# class StatTracker
#   ## This -below- is the class method (indicated by the self.)
#   def self.from_csv(locations)   ##locations is a hash of the file paths.
#     all_games = []
#     games = CSV.foreach(locations[:games], :headers => true) do |row| ## this is our array of games
#     all_games << Game.new(row)
#     end
#     StatTracker.new(all_games) ## this is creating an instance of the class
#   end

#   def initialize(games)
#     @games = games.to_a
#   end

  # def highest_total_score
  #   #  @games[0]["home_goals"].to_i + @games[0]["away_goals"].to_i
  #   output = @games.max_by do |game|
  #     game.total_game_score
  #   end
  #   output.total_game_score
  # end

# end
