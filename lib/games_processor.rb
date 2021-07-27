require 'csv'

module GamesProcessor
  def parse_games_file(file_path)
    games = []

    CSV.foreach(file_path, headers: true) do |row|
      games << {
        game_id: row["game_id"],
        season: row["season"],
        away_team_id: row["away_team_id"],
        home_team_id: row["home_team_id"],
        away_goals: row["away_goals"],
        home_goals: row["home_goals"]
      }
    end
    games
  end

  def all_team_games(team_id)
    @games.find_all do |game|
      game[:home_team_id] == team_id || game[:away_team_id] == team_id
    end
  end

  def best_season(team_id)
    games = all_team_games(team_id)
  end

  def team_games_by_season(team_id)
    all_team_games(team_id).group_by do |game|
      game[:season]
    end
  end
end
