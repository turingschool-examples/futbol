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
    (goals.fdiv(@game_teams.size) * 2).round(2)
  end

  def average_goals_by_season
    goals_per_season.reduce({}) do |acc, season_goals|
      acc[season_goals[0]] = season_goals[1].fdiv(games_per_season(season_goals[0])).round(2)
      acc
    end
  end

  def goals_per_game(game)
    game[:away_goals].to_i + game[:home_goals].to_i
  end

  def goals_per_season
    goals = {}
    @games.each do |game|
      goals[game[:season]] ||= 0
      goals[game[:season]] += goals_per_game(game)
    end
    goals
  end

  def games_per_season(season)
    @games.count do |game|
      game if game[:season] == season
    end
  end
end
