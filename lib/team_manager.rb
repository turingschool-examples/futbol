require 'CSV'
require_relative './team'

class TeamManager
  attr_reader :teams

  def initialize(file_path)
    @file_path = file_path
    @teams = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      @teams[row["team_id"]] = Team.new(row)
    end
  end

  def count_of_teams
    @teams.count
  end

  def teams_by_id
    teams_by_id = {}
    @teams.each do |team_id, team|
      teams_by_id[team_id] = team.teamname
    end
    teams_by_id
  end

  def team_info(team_id)
    {
      "team_id"      => @teams[team_id].team_id,
      "franchise_id"  => @teams[team_id].franchiseid,
      "team_name"     => @teams[team_id].teamname,
      "abbreviation" => @teams[team_id].abbreviation,
      "link"         => @teams[team_id].link
    }
  end
end
