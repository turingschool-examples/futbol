require_relative './calculateable'
require_relative './gatherable'

module LeagueStats
  include Calculateable
  include Gatherable

  def count_of_teams
    @teams.collection.length
  end

  def best_offense
    team_id = team_average_goals(goals_by_team).max_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def worst_offense
    team_id = team_average_goals(goals_by_team).min_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def best_defense
    team_id = team_average_goals(goals_against_team).min_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def worst_defense
    team_id = team_average_goals(goals_against_team).max_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def highest_scoring_visitor
    team_id = team_average_goals(away_goals_by_team).max_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def highest_scoring_home_team
    team_id = team_average_goals(home_goals_by_team).max_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def lowest_scoring_visitor
    team_id = team_average_goals(away_goals_by_team).min_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def lowest_scoring_home_team
    team_id = team_average_goals(home_goals_by_team).min_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def winningest_team
    team_id = team_win_percentage(wins_by_team(@games.collection)).max_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def best_fans
    team_home_avg = team_away_average_wins(home_wins_by_team)
    team_away_avg = team_away_average_wins(away_wins_by_team)
    difference = league_win_percent_diff(team_home_avg, team_away_avg)

    team_id = difference.max_by { |_id, diff| diff }[0]

    get_team_name_by_id(team_id)
  end

  def worst_fans
    team_home_avg = team_away_average_wins(home_wins_by_team)
    team_away_avg = team_away_average_wins(away_wins_by_team)
    difference = worst_team_helper(team_home_avg, team_away_avg)

    difference.keys.map { |team_id| get_team_name_by_id(team_id) }
  end
end
