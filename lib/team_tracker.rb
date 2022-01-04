require 'csv'
require './lib/team'

#require '../data/teams_stub.csv'

class TeamTracker
  attr_reader :teams

  def initialize
    @@teams = create_teams
  end

  def create_teams
    @teams = []
    contents = CSV.open './data/teams_stub.csv', headers:true, header_converters: :symbol
    contents.each do |row|
      team_id = row[:team_id]
      franchise_id = row[:franchiseid]
      team_name = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
    end
    @teams
  end

  def team_info(team)
    team_hash = {}
    team.instance_variables.each do |variable|
      variable = variable.to_s.delete! '@'
      team_hash[variable.to_sym] = team.instance_variable_get("@#{variable}".to_sym)
    end
    team_hash
  end
end
tracker = TeamTracker.new
#p tracker.teams
p tracker.team_info(tracker.teams[1])
