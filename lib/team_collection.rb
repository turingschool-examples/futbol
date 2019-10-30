require 'csv'
require_relative 'team'

class TeamCollection
  attr_reader :teams

  def initialize(csv_path)
    @teams = create_teams(csv_path)
  end

  def create_teams(csv_path)
    csv = CSV.read("#{csv_path}", headers: true, header_converters: :symbol)
    csv.map {|row| Team.new(row)}
  end

  def total_teams
    @teams.length
  end

  def find_team_name_by_id(team_id)
    team = @teams.find do |team|
      team.team_id.to_i == team_id
    end
  team.team_name
  end

end
