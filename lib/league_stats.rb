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


  def worst_defense
    #
  end

  def highest_scoring_visitor
    #
  end

  def winningest_team
    winning_team_id = @team_result_count.max_by do |team_id, counts|
      (counts[:home_wins] + counts[:away_wins]) / counts[:games].to_f if counts[:games] != 0
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
      counts[:away_wins] > counts[:home_wins]
    end

    team_names = []
    worst_fans_teams.each do |team|
      team_names << @teams[team[0]].team_name
    end

    team_names
  end

end
