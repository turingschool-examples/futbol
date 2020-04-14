require_relative "stats"

class LeagueStats < Stats

  def initialize(file_path)
    Stats.from_csv(file_path)
  end

  def count_of_teams
    @@teams.length
  end

  def best_offense
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def worst_offense
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id)}
    team_by_id(id).team_name
  end

  def highest_scoring_visitor
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def highest_scoring_home_team
    id = unique_team_ids.max_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

  def lowest_scoring_visitor
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "away")}
    team_by_id(id).team_name
  end

  def lowest_scoring_home_team
    id = unique_team_ids.min_by {|team_id| average_goals_by_team(team_id, "home")}
    team_by_id(id).team_name
  end

end
