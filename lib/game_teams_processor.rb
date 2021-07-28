require 'csv'

module GameTeamsProcessor
  def parse_game_teams_file(file_path)
    game_teams = []

    CSV.foreach(file_path, headers: true) do |row|
      game_teams << {
        game_id: row["game_id"],
        team_id: row["team_id"],
        home_away: row["HoA"],
        result: row["result"],
        coach: row["head_coach"],
        goals: row["goals"],
        shots: row["shots"],
        tackles: row["tackles"]
      }
    end
    game_teams
  end

  def most_goals_scored(team_id)
    goals = goals_per_team_game(team_id)
    goals.max_by do |goal|
      goal.to_i
    end.to_i
  end

  def goals_per_team_game(team_id)
    goals = []
    @game_teams.each do |game|
      goals << game[:goals] if game[:team_id] == team_id
    end
    goals
  end

  def fewest_goals_scored(team_id)
    goals = goals_per_team_game(team_id)
    goals.min_by do |goal|
      goal.to_i
    end.to_i
  end

  def average_goals_per_game
    goals = @game_teams.sum do |game|
      game[:goals].to_f
    end
    (goals.fdiv(@game_teams.size) * 2).round(2)
  end

  def winningest_coach(season)
    most_wins = coach_win_pct(season).max_by do|coach, pct|
      pct
    end
    most_wins[0]
  end

  def worst_coach(season)
    least_wins = coach_win_pct(season).min_by do|coach, pct|
      pct
    end
    least_wins[0]
  end

  def coach_win_pct(season)
    coach_wins(season).each.reduce({}) do |acc, (coach, results)|
      acc[coach] = results[:wins].fdiv(results[:total])
      acc
    end
  end

  def coach_wins(season)
    @game_teams.reduce({}) do |acc, game|
      if game[:game_id][0..3] == season[0..3]
        acc[game[:coach]] ||= {wins: 0, total: 0}
        if game[:result] == "WIN"
          acc[game[:coach]][:wins] += 1
        end
        acc[game[:coach]][:total] += 1
      end
      acc
    end
  end

  def team_tackles(season)
    @game_teams.reduce({}) do |acc, game|
      if game[:game_id][0..3] == season[0..3]
        acc[game[:team_id]] ||= 0
        acc[game[:team_id]] += game[:tackles].to_i
      end
      acc
    end
  end

  def most_tackles(season)
    most = team_tackles(season).max_by do |team, tackles|
      tackles
    end
    team_info(most[0])["team_name"]
  end

  def fewest_tackles(season)
    fewest = team_tackles(season).min_by do |team, tackles|
      tackles
    end
    team_info(fewest[0])["team_name"]
  end
end
