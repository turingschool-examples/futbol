require_relative './helper'

module LeagueStats
  include Helper

  def league_rspec_test
    true
  end

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor
    away_teams = @games.group_by(&:away_team_id)
    away_teams_ave_score = {}
    away_teams.each do |team, values|
      away_teams_ave_score[team] = average_away_goals(values)
    end
    highest_scoring = away_teams_ave_score.max_by {|_, value| value}
    convert_to_team_name(highest_scoring[0])
  end

  def highest_scoring_home_team

  end
  
  def lowest_scoring_visitor
    away_teams = @games.group_by(&:away_team_id)
    away_teams_ave_score = {}
    away_teams.each do |team, values|
      away_teams_ave_score[team] = average_away_goals(values)
    end
    highest_scoring = away_teams_ave_score.min_by {|_, value| value}
    convert_to_team_name(highest_scoring[0])
  end

  def lowest_scoring_home_team

  end
end