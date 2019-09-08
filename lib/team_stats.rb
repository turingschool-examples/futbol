module TeamStats
  def most_goals_scored(team_id)
    team_id = team_id.to_i
    most_goals = 0
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          most_goals = game_team.goals if game_team.goals > most_goals
        end
      end
    end
    most_goals
  end

  # highest number of goals a team has scored in a particular game

  def fewest_goals_scored(team_id)
    team_id = team_id.to_i
    fewest_goals = 50
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          fewest_goals = game_team.goals if game_team.goals < fewest_goals
        end
      end
    end
    fewest_goals
  end
end
