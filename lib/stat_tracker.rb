require 'csv'
require './creator'
class StatTracker
  attr_reader :game_data,
              :team_data,
              :game_team_data,
              :creator

  def initialize(game_data, team_data, game_team_data)
    @game_data      = game_data
    @team_data      = team_data
    @game_team_data = game_team_data
    @creator = Creator.create_objects(game_data, team_data, game_team_data)
  end

  def self.from_csv(locations)
    game_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    team_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_team_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    self.new(game_data, team_data, game_team_data)
  end
end
