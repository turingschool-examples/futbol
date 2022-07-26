require 'csv'
require 'games'

class StatTracker
  attr_reader :locations, :data

  def initialize(game_path, team_path, game_teams_path)
    # @locations = locations
    # @data = {}
    # locations.each_key do |key|
    #   data[key] = CSV.read locations[key]
    # end
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    # games = Games.new(locations[:games])
  end

  def self.from_csv(locations)
    StatTracker.new(
      locations[:games],
      locations[:teams],
      locations[:game_teams]
    )
  end

  def highest_total_score
    CSV.foreach(game_path) do ||
  end
end
