require 'csv'
require_relative 'team'

class TeamCollection
  attr_reader :team_instances

  def initialize(team_path)
    @team_path = team_path
    @team_instances = all_teams
  end

  def all_teams
    csv = CSV.read("#{@team_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      Team.new(row)
    end
  end

  def count_of_teams
    id_list = @team_instances.map do |team|
      team.team_id
    end
    id_list.uniq.length
  end

  def highest_scoring_visitor(team_id)
require "pry"; binding.pry
   highest_visitor_score
  end
end
