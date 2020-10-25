require 'csv'

class TeamManager
  attr_reader :teams_data, :teams

  def initialize(file_locations)
    @teams_data = file_locations[:teams]
  end

  def all
    teams = []
    CSV.foreach(@teams_data, header_converters: :symbol, headers: true) do |row|
      team_data = {
        team_id: row[:team_id],
        franchise_id: row[:franchise_id],
        team_name: row[:team_name],
        abbreviation: row[:abbreviation],
        stadium: row[:stadium],
        link: row[:link]
      }
      teams << Team.new(team_data)
    end
    teams
  end

end
