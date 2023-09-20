require 'csv'

class Gamestatistics
  attr_reader :locations, :teams_data, :game_data, :game_team_data

  def initialize(locations)#
    @locations = locations 
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
end