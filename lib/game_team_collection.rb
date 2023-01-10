require 'csv'
require_relative '../lib/game_team'

class GameTeamCollection
  attr_reader :game_teams_array

  def initialize(location)
    @game_teams_array = []
	  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
	  @game_teams_array << GameTeam.new(row)
    end
  end
end