require 'csv'

module LeagueStatistics
  # Original method from iteration 2
  def count_of_teams
    @teams.length
  end

  # Original method from iteration 2
  def best_offense
    team_goals_per_game = avg_goals_per_game
    # Find the team_id and name of the team w/ highest avg goals
    best_offense_id = team_goals_per_game.max_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find {|team| team[:team_id] == best_offense_id}[:teamname]
  end

  # Original method from iteration 2
  def worst_offense
    team_goals_per_game = avg_goals_per_game
    worst_offense_id = team_goals_per_game.min_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find {|team| team[:team_id] == worst_offense_id}[:teamname]
  end

  # Original method from Iteration 2
  def highest_scoring_visitor
    average_scores_for_all_visitors
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  # Original method from Iteration 2
  def highest_scoring_home_team
    average_scores_for_all_home_teams
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @home_hash.key(@home_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  # Original method from Iteration 2
  def lowest_scoring_visitor
    average_scores_for_all_visitors
    lowest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.min)
    end
    lowest_scoring_team[:teamname]
  end

  # Original method from Iteration 2
  def lowest_scoring_home_team
    average_scores_for_all_home_teams
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @home_hash.key(@home_hash.values.min)
    end
    highest_scoring_team[:teamname]
  end
end
