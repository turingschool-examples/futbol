require_relative 'team'
require 'csv'

class TeamManager
  attr_reader :teams, :teams_data
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = generate_teams(locations[:teams])
    @teams_data = team_data_by_id
  end

  def generate_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Team.new(row.to_hash)
    end
    array
  end

  def team_info(team_id)
    teams_data[team_id]
  end

  def team_data_by_id
    @teams.map{|team| [team.team_id, team.team_info]}.to_h
  end

  def count_of_teams
    teams_data.count
  end
end
