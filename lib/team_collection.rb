require_relative 'team'
require 'CSV'

class TeamCollection
  attr_reader :teams, :team_objs

  def initialize(csv_file_path)
    @team_objs = []
    @teams = create_teams(csv_file_path)
  end

  def create_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    team_obj = 0
    csv.map do |row|
      team_obj = Team.new(row)
      @team_objs << team_obj
    end
  end
end
