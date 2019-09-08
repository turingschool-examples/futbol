module LeagueStats

  def count_of_teams
    @teams.length
    #works fine but when we refactor we should consider doing this with uniq so that
    #if there are repetitive teams it still works.
  end

  def best_offense
    highest_average_number_of_goals_id = @team_result_count.max_by do |team_id, counts|
      counts[:total_goals] / counts[:games].to_f
    end[0]

    @teams[highest_average_number_of_goals_id].team_name
  end

  def worst_offense
    lowest_average_number_of_goals_id = @team_result_count.min_by do |team_id, counts|
      counts[:total_goals] / counts[:games].to_f
    end[0]

    @teams[lowest_average_number_of_goals_id].team_name
  end

  def best_defense
    best_def_id = @team_result_count.min_by do |team_id, counts|
      counts[:goals_allowed] / counts[:games].to_f
    end[0]

    @teams[best_def_id].team_name
  end

  def worst_defense
    worst_def_id = @team_result_count.max_by do |team_id, counts|
      counts[:goals_allowed] / counts[:games].to_f
    end[0]

    @teams[worst_def_id].team_name
  end

  def highest_scoring_visitor
    highest_scoring_visitor_id = @team_result_count.max_by do |team_id, counts|
      counts[:away_goals] / counts[:away_games].to_f
    end[0]
    
    @teams[highest_scoring_visitor_id].team_name
  end

  def highest_scoring_home_team
    highest_scoring_home_team_id = @team_result_count.max_by do |team_id, counts|
      counts[:home_goals] / counts[:home_games].to_f
    end[0]

    @teams[highest_scoring_home_team_id].team_name
  end

  def lowest_scoring_visitor
    lowest_scoring_visitor_id = @team_result_count.min_by do |team_id, counts|
      counts[:away_goals] / counts[:away_games].to_f
    end[0]

    @teams[lowest_scoring_visitor_id].team_name
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team_id = @team_result_count.min_by do |team_id, counts|
      counts[:home_goals] / counts[:home_games].to_f
    end[0]

    @teams[lowest_scoring_home_team_id].team_name
  end

  def winningest_team
    winning_team_id = @team_result_count.max_by do |team_id, counts|
      (counts[:home_wins] + counts[:away_wins]) / counts[:games].to_f
    end[0]

    @teams[winning_team_id].team_name
  end

  def best_fans
    best_fans_team_id = @team_result_count.max_by do |team_id, counts|
      ((counts[:home_wins] / counts[:games].to_f) - (counts[:away_wins] / counts[:games].to_f)).abs
    end[0]

    @teams[best_fans_team_id].team_name
  end

  def worst_fans
    worst_fans_teams = @team_result_count.find_all do |team_id, counts|
      (counts[:away_wins] / counts[:away_games]) > (counts[:home_wins] / counts[:home_games])
    end

    team_names = []
    worst_fans_teams.each do |team|
      team_names << @teams[team[0]].team_name
    end

    team_names
  end

end
