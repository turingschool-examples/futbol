require_relative 'league_stat_helper'

class LeagueStatistics < LeagueStatHelper

  def count_of_teams
    @team.length
  end

  def best_offense
    best_season_average = team_season_average
    best_season_average.key(best_season_average.values.max)
  end

  def worst_offense
    worst_season_average = team_season_average
    worst_season_average.key(worst_season_average.values.min)
  end

  def highest_scoring_visitor
    best_team_away_average = team_away_average
    best_team_away_average.key(best_team_away_average.values.max)
  end

  def highest_scoring_home_team
    best_home_average = team_home_average
    best_home_average.key(best_home_average.values.max)
  end

  def lowest_scoring_visitor
    worst_team_away_average = team_away_average
    worst_team_away_average.key(worst_team_away_average.values.min)
  end

  def lowest_scoring_home_team
    worst_team_home_average = team_home_average
    worst_team_home_average.key(worst_team_home_average.values.min)
  end
end
