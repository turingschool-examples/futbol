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

  def winningest_team(team_id)
    #untested
    @team_instances.each do |team|
      if team[:team_id] == team_id
        team[:teamname]
      end
    end
  end
end
