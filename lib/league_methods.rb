module LeagueMethods

  def count_of_teams(teams)
    teams.count
  end

  def calc_avg_goals_alltime(game_teams, team_id, location = nil)

    goals = []

    #for all available games across all seasons,
      # if location isn't set, just iterate over all objects and aggregate the goals
      # if location IS set, only aggregate the goals for that location, home vs. away 

    game_teams.each do |game_team|
      if location == nil
        if game_team.team_id == team_id
          goals << game_team.goals
        end
      elsif location == "home"
        if game_team.team_id == team_id && game_team.HoA == "home"
          goals << game_team.goals
        end
      elsif location == "away"
        if game_team.team_id == team_id && game_team.HoA == "away"
          goals << game_team.goals
        end
      end
    end
    sum = goals.sum.to_f
    count = goals.count.to_f
    average = (sum / count)
    average
  end

  # highest scorer, with optional location representing away or home
  def best_offense(game_teams, teams, location = nil)
    averages = []
    teams.each do |team|
      averages << [team, self.calc_avg_goals_alltime(game_teams, team.team_id, location)]
    end
    max = averages.max {|a, b| a[1] <=> b[1]}
    max[0].teamName
  end

  # lowest scorer, with optional location representing away or home
  def worst_offense(game_teams, teams, location = nil)
    averages = []
    teams.each do |team|
      averages << [team, self.calc_avg_goals_alltime(game_teams, team.team_id, location)]
    end
    min = averages.min {|a, b| a[1] <=> b[1]}
    min[0].teamName
  end

  # team with highest average score per game, all-time, when playing away
  def highest_scoring_visitor(game_teams, teams)
    best_offense(game_teams, teams, "away")
  end

  # team with the highest average score per game, all-time, at home
  def highest_scoring_home_team(game_teams, teams)
    best_offense(game_teams, teams, "home")
  end

  # team with lowest average score per game, all-time, when playing away
  def lowest_scoring_visitor(game_teams, teams)
    worst_offense(game_teams, teams, "away")
  end

  # team with the lowest average score per game, all-time, at home
  def lowest_scoring_home_team(game_teams, teams)
    worst_offense(game_teams, teams, "home")
  end

end
