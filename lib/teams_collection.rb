require_relative 'team'
require 'csv'

class TeamsCollection
  attr_reader :teams

  def initialize(teams_path)
    @teams = generate_objects_from_csv(teams_path)
  end

  def generate_objects_from_csv(csv_teams_path)
    objects = []
    CSV.foreach(csv_teams_path, headers: true, header_converters: :symbol) do |row_object|
      objects << Team.new(row_object)
    end
    objects
  end

  def count_of_teams
    @teams.count {|team| team.team_id.length}
  end
end
