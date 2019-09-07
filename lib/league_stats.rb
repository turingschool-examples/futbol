module LeagueStats

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

  def highest_scoring_home_team
    # set these to 0 because we're just counting them
    num_home_goals = Hash.new(0)
    num_games = Hash.new(0)

    @games.each do |game_id, game|

      # for each team, we want the name of the team with the highest average score per game across all seasons when they are home

      num_games[game.home_team_id] += 1
      num_home_goals[game.home_team_id] += game.home_goals
    end

    greatest = [nil, 0]
    @teams.each do |team_id, team|
      if num_games[team_id] > 0
        average = num_home_goals[team_id].to_f / num_games[team_id]
        greatest = [team_id, average] if average > greatest[1]
      end
    end

    @teams[greatest[0]].team_name



    # # want to take each return value, find the max, and then return the team name associated with the team_id
    # goal_average.max_by do |average|
    #   average
    # end
  end
end
