require 'csv'
require_relative 'team'
require_relative 'stat_tracker'

class TeamCollection
  attr_reader :team_instances

  def initialize(team_path)
    @team_path = team_path
    @team_instances = all_teams
  end

  def all_teams
    team_objects = []
    csv = CSV.read("#{@team_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      team_objects <<  Team.new(row)
    end
    team_objects
  end
end
