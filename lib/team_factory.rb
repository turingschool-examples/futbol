require 'csv'

class TeamFactory

    attr_reader :file_path,
                :teams

  def initialize(file_path)
    @file_path = file_path
    @teams = []
  end

  def create_teams
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      team_info = {}
      team_info[:team_id] = row[:team_id].to_i
      team_info[:team_name] = row[:teamname]

      @teams << Team.new(team_info)
    end
    @teams
  end
end