module LeagueModule
  def count_of_teams
    teams.length
  end

  def best_offense
    team_id = self.generate_avg_goals_by_team.max_by {|team, avg| avg}
    self.convert_ids_to_team_name(team_id)
  end

  def worst_offense
    team_id = self.generate_avg_goals_by_team.min_by {|team, avg| avg}
    self.convert_ids_to_team_name(team_id)
  end

  def best_defense
    
  end

  def worst_defense

  end

  def highest_scoring_visitor

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

  ##Helper Methods##
  def generate_avg_goals_by_team
    games_by_team = game_teams.group_by do |game|
      game.team_id
    end
    games_by_team.transform_values do |val|
      games = val.length
      val.map {|v| v.goals}.reduce {|sum, num| sum + num} / games
    end
    games_by_team
  end

  def convert_ids_to_team_name(id)
    ids_to_name = teams.group_by {|team| team.team_id}.transform_values {|obj| obj.team_name}
    ids_to_name[id]
  end
end
