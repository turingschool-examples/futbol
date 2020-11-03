require "csv"
require_relative "./team"

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

# League Stats
  def count_of_teams
    @teams.count
  end

  def find_team_name(team_id)
    @teams.find do |team|
      team_id == team.team_id
    end.team_name
  end

  # Team Stats
  def team_info(team_id)
    team_data = {}
    @teams.each do |team|
     if team_id  == team.team_id
       team_data = {
                  team_id: team.team_id,
                  franchise_id: team.franchise_id,
                  team_name: team.team_name,
                  abbreviation: team.abbreviation,
                  link: team.link
                }
      end
    end
    team_data
  end
end
