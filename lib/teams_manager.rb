require 'csv'
require './lib/team'

class TeamsManager
  attr_reader :teams

  def initialize(file_path)
    @teams = []
    make_teams(file_path)
  end

  # Helper
  def make_teams(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @teams << Team.new(row)
    end
  end

  # Interface
  def team_info(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  # Interface
  def count_of_teams
    @teams.count
  end

  # Interface
  def team_by_id(team_id)
    team = @teams.find do |team|
      team.team_id == team_id
    end
    team.team_name
  end

end
