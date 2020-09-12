require_relative 'team'
require 'csv'

class TeamManager
  attr_reader :teams
  def initialize(location, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = generate_teams(location)
  end

  def generate_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Team.new(row.to_hash)
    end
    array
  end

  def team_info(team_id)
    teams.find do |team_obj|
      team_obj.team_id == team_id
    end.team_info
  end
end
