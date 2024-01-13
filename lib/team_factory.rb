require 'csv'

class TeamFactory

    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def create_teams
      teams = []
      CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
        team_info = {}
        team_info[:team_id] = row[:team_id].to_i
        team_info[:franchise_id] = row[:franchiseid].to_i
        team_info[:team_name] = row[:teamname]
        team_info[:abbreviation] = row[:abbreviation]
        team_info[:stadium] = row[:stadium]
        team_info[:link] = row[:link]

        teams << Team.new(team_info)
      end
      teams
    end
end