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
    @game_teams.filter_map do |game|
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
    (goals / @game_teams.size * 2).round(2)
  end
end
