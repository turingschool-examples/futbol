require 'csv'
require_relative 'game_teams'
require_relative 'stat_tracker'

class GameTeamsCollection
  attr_reader :game_teams_instances

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_instances = all_stats
  end

  def all_stats
    game_teams_objects = []
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      game_teams_objects <<  GameTeams.new(row)
    end
    game_teams_objects
  end
end
