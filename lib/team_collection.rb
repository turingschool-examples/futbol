require 'csv'
require_relative 'team'

class TeamCollection
  attr_reader :teams

  def initialize(csv_file_path)
    @teams = create_teams(csv_file_path)
  end

  def create_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Team.new(row)
    end
  end

  def count_of_teams
    @teams.length
  end

  def team_info(team_id)
    team_information = {}
    team_object = @teams.find {|team| team.team_id == team_id_number}
    team_information[:team_id] = team_object.team_id
    team_information[:franchiseid] = team_object.franchiseid
    team_information[:teamname] = team_object.teamname
    team_information[:abbreviation] = team_object.abbreviation
    team_information[:link] = team_object.link
    team_information
  end
end
