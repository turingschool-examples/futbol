require "csv"
require "./lib/team"

class TeamCollection
  attr_reader :team_path, :stat_tracker

  def initialize(team_path, stat_tracker)
    @team_path    = team_path
    @stat_tracker = stat_tracker
    @teams        = []
    create_teams(team_path)
  end

  def create_teams(team_path)
    data = CSV.parse(File.read(team_path), headers: true)
    @teams = data.map {|data| Team.new(data, self)}
  end

  # def find_team(team_id)
  #   team = @teams.find do |team|
  #   team.team_id == team_id
  #   end
  #   team.team_name
  # end

  def count_of_teams
    @teams.count
  end

  def find_team_name(team_id)
    @teams.find do |team|
      team_id == team.team_id
    end.team_name
  end
end
