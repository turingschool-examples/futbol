module LeagueModule
  def count_of_teams
    teams.length
  end

  def best_offense
    # goals_by_team = Hash.new
    # teams.each {|team| goals_by_team[team] = 0}


  end

  def worst_offense

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
      val.map {|v| v.goals}.reduce {|sum, num| sum + num} / val.length
    end
    games_by_team
  end

  def convert_ids_to_team_name(id)

  end   
end
