require_relative "team_data"
require_relative "game_team_data"
class LeagueStatistics

  def initialize

  end

  def all_teams
    TeamData.create_objects
  end

  def count_of_teams
    all_teams.size
  end

end
