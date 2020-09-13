require_relative 'game_teams'
require 'csv'

class GameTeamManager
  attr_reader :game_teams
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams = generate_game_teams(locations[:game_teams])
  end

  def generate_game_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << GameTeams.new(row.to_hash)
    end
    array
  end
end
