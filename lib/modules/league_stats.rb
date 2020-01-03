require_relative './calculateable'
require_relative './gatherable'

module LeagueStats
  include Calculateable
  include Gatherable

  def count_of_teams
    @team_collection.collection.length
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
    team_id = team_average_wins(wins_by_team).max_by { |_id, avg| avg }[0]

    get_team_name_by_id(team_id)
  end

  def best_fans
    # logic
  end

  def worst_fans
    # logic
  end
end
