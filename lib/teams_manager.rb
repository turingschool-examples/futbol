require 'csv'
require_relative './stat_tracker'
require_relative './team'

class TeamsManager
  attr_reader :stat_tracker, :teams

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = []
    create_teams(path)
  end

  def create_teams(teams_table)
    @teams = teams_table.map do |data|
      Team.new(data)
    end
  end

  def count_of_teams
    @teams.count
  end

  def all_team_ids
    @teams.map do |team|
      team.team_id
    end
  end

end
