require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
teams_test_path = './data/teams_test.csv'
games_test_path = './data/games_test.csv'
game_teams_test_path = './data/game_teams_test.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path,
  teams_test: teams_test_path,
  games_test: games_test_path,
  game_teams_test: game_teams_test_path
}

stat_tracker = StatTracker.from_csv(locations)


# require "pry";binding.pry
