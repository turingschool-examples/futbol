require 'csv'

class TeamData
  attr_reader :teams
  
  def initialize
    @teams = []
  end

  def add_teams
    teams = CSV.open './data/teams.csv', headers: true, header_converters: :symbol
    teams.each do |row|
      team_id = row[:team_id]
      franchiseid = row[:franchiseid]
      teamname = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id, franchiseid, teamname, abbreviation, stadium, link)
    end
  end
end