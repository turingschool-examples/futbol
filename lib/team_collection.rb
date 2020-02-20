require './lib/team'
require 'csv'

class TeamCollection
  attr_reader :teams

  def initialize(team_file_path)
    @teams = create_teams(team_file_path)
  end

  def create_teams(team_file_path)
    @team_data = CSV.read(team_file_path, headers: true, header_converters: :symbol)
    @team_data.map do |row|
      Team.new(row.to_h)
    end
  end
end
