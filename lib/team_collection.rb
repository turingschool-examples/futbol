require 'csv'
require_relative 'team'

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

  def highest_scoring_visitor
  x = @game_instances.highest_visitor_score
  end
end
