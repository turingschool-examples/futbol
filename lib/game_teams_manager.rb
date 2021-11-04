require 'CSV'
require 'pry'

require_relative './teams'

class GameTeamManager
  attr_reader :game_teams_objects, :game_teams_path

  def initialize(game_teams_path)
    @game_teams_path = './data/game_teams.csv'
    @game_teams_objects = (
      objects = []
      CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
        objects << GameTeams.new(row)

      end
      objects)

  end


end
