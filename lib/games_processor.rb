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
end
