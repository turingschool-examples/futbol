require_relative 'collection'

class Team < Collection

  def self.find_team_info(id)
    id = id
    selected_team = all.find{|team| team.team_id==id}
    team_info = {}
    team_info["abbreviation"]= selected_team.abbreviation
    team_info["franchise_id"]= selected_team.franchise_id
    team_info["link"]= selected_team.link
    team_info["team_id"]= selected_team.team_id
    team_info["team_name"]= selected_team.team_name
    team_info
  end

  def self.count_of_teams
    all.length
  end

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link, :team_name

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseid]
    @team_name = team_info[:team_name]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
    @team_name = team_info[:teamname]
  end
end
