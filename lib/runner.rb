require './lib/stat_tracker'

game_path = './test/fixtures/games_truncated.csv'
team_path = './test/fixtures/teams_truncated.csv'
game_teams_path = './test/fixtures/game_teams_truncated.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
