module Helpable
  def setup
    @locations = {
      # games: './data/games.csv',
      teams: './data/teams.csv',
      # game_teams: './data/game_teams.csv',
      games: './data/games_truncated.csv',
      game_teams: './data/game_teams_truncated.csv'
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end
end
