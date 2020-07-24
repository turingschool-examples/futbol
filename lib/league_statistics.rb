require_relative "team_data"
require_relative "game_team_data"
class LeagueStatistics

  def initialize
    @team_name_by_id = Hash.new{}

  end

  def all_teams
    TeamData.create_objects
  end

  def count_of_teams
    all_teams.size
  end

  def get_team_name_by_id
    all_teams.each do |team|
      @team_name_by_id[team.team_id] = team.team_name
    end
    @team_name_by_id
  end

  def best_offense
  end

end
