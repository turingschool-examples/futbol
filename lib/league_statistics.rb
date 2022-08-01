require_relative './league_helper_module'
require_relative './team_name_by_id_helper_module'

class LeagueStatistics < StatTracker
  include Leagueable
  include TeamNameable
  def initialize(team_data, game_teams_data)
    @teams_data = team_data
    @game_teams_data = game_teams_data
  end

  def count_of_teams
    @teams_data.select { |team| team[:team_id] }.count
  end

  def best_offense 
    team_best_offense = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(team_best_offense)
  end 

  def worst_offense
    team_worst_offense = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(team_worst_offense)
  end

  def highest_scoring_visitor
    highest_score_visitor = team_away_average_goals.key(team_away_average_goals.values.max)
    find_team_name_by_id(highest_score_visitor)
  end

  def highest_scoring_home_team  
    highest_score_home_team = team_home_average_goals.key(team_home_average_goals.values.max)
    find_team_name_by_id(highest_score_home_team)
  end

  def lowest_scoring_visitor
    lowest_score_visitor = team_away_average_goals.key(team_away_average_goals.values.min)
    find_team_name_by_id(lowest_score_visitor)
  end

  def lowest_scoring_home_team
    lowest_score_home_team = team_home_average_goals.key(team_home_average_goals.values.min)
    find_team_name_by_id(lowest_score_home_team)
  end
end