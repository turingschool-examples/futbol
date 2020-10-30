require "csv"
require "./lib/team"

class TeamLoader
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
end
