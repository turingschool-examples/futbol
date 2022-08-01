require './lib/league_helper_module'
require './lib/team_name_by_id_helper_module'

class LeagueStatistics
  include Leagueable
  include TeamNameable
  def initialize
    @teams_data = CSV.read "./data/teams.csv", headers: true, header_converters: :symbol
    @game_teams_data = CSV.read "./data/mock_game_teams.csv", headers: true, header_converters: :symbol
  end

  def count_of_teams
    @teams_data.select do |team|
      team[:team_id]
    end.count
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