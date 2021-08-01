require 'CSV'
require_relative './team'

class TeamManager
  attr_reader :teams

  def initialize(file_path)
    @file_path = file_path
    @teams = load
  end

  def load # CHANCE FOR Inheritance
    teams = []
    data = CSV.read(@file_path, headers: true)
    data.each do |row| #change this to map later
      team = Team.new(row)
      teams.push(team)
    end
    teams
  end

  def count_of_teams
    @teams.count
  end

  def team_by_id(team_id)
    team = @teams.find do|team|
      team.team_id == team_id
    end
  end

  def team_name_by_id(team_id)
    team_by_id(team_id).teamname
  end

  def team_info(team_id)
    {
      "team_id"      => team_by_id(team_id).team_id,
      "franchise_id"  => team_by_id(team_id).franchiseid,
      "team_name"     => team_by_id(team_id).teamname,
      "abbreviation" => team_by_id(team_id).abbreviation,
      "link"         => team_by_id(team_id).link
    }
  end
end
