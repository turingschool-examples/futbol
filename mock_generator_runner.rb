require './lib/mock_csv_generator'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
mock_game_teams_path = './data/mock_game_teams.csv'
mock_games_path = './data/mock_games.csv'
generated_mock_games_path = './data/generated_mock_games.csv'


locations = {
  games: game_path,
  game_teams: game_teams_path,
  generated_mock_game_teams: generated_mock_games_path
            }

generator = MockGenerator.from_csv(locations)
