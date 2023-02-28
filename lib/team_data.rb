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
      francise_id = row[:franchise_id]
      team_name = row[:team_name]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
    end
  end
end