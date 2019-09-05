module LeagueStat

  def count_of_teams
    all_teams.length
  end

  def team_id_and_goals
    team_id_goals = Hash.new(0)
    all_game_teams.each do |game_team|
      team_id_goals[game_team.team_id] += game_team.goals
    end
    team_id_goals
  end

  def best_offense
    best_offense = team_id_and_goals.max_by do |id, goals|
      goals
    end
    all_teams.find {|team| best_offense[0] == team.team_id}.team_name
  end

  def worst_offense
  end

  def best_defense
  end

  def worst_defense
  end

  def highest_scoring_visitor
  end

  def highest_scoring_home_team
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
  end

  def winningest_team
  end

  def best_fans
  end

  def worst_fans
  end
end
