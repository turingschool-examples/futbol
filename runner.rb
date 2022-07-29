require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
mock_game_teams_path = './data/mock_game_teams.csv'
mock_games_path = './data/mock_games.csv'


locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path,
  mock_game_teams: mock_game_teams_path,
  mock_games: mock_games_path
            }

stat_tracker = StatTracker.from_csv(locations)



