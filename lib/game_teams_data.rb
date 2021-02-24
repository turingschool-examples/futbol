require 'CSV'
require 'pry'
require './lib/game_teams'

class GameTeamsData
  def initialize
    @all_game_teams_data = []
    # @stattracker = stattracker

    CSV.foreach('./data/game_teams.csv', headers: true, header_converters: :symbol) do |row|
      @all_game_teams_data << GameTeams.new(row)
    end
    # binding.pry
  end
end
