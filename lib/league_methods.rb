module LeagueMethods

  def count_of_teams(teams)
    teams.count
  end

  def calc_average_goals_alltime(game_teams, team_id)

    goals = []

    game_teams.each do |game_team|
      if game_team.team_id == team_id
        goals << game_team.goals
      end
    end
    sum = goals.sum.to_f
    count = goals.count.to_f
    average = (sum / count).to_f
    average
  end

  def best_offense(game_teams, teams)
    averages = []
    teams.each do |team|
      averages << [team, self.calc_average_goals_alltime(game_teams, team.team_id)]
    end
    max = averages.max {|a, b| a[1] <=> b[1]}
    max[0].teamName
  end

  def worst_offense(game_teams, teams)
    averages = []
    teams.each do |team|
      averages << [team, self.calc_average_goals_alltime(game_teams, team.team_id)]
    end
    min = averages.min {|a, b| a[1] <=> b[1]}
    min[0].teamName
  end
end
