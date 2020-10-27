require_relative './team'
require 'CSV'

class TeamsCollection
  attr_reader :teams
  def initialize(file_path)
    @teams = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      team_id = row[:team_id]
      franchiseid = row[:franchiseid]
      teamname = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id,franchiseid,teamname,abbreviation,stadium,link)
    end
  end

  def count_of_teams
    @teams.length
  end

  def team_info(team_id)
    team = @teams.find do |team|
      team.team_id == team_id
    end
    new_team_info = {}
    new_team_info["team_id"] = team.team_id
    new_team_info["franchise_id"] = team.franchiseid
    new_team_info["team_name"] = team.teamname
    new_team_info["abbreviation"] = team.abbreviation
    new_team_info["link"] = team.link
    new_team_info
  end
end
