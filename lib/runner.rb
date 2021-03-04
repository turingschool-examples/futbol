require_relative './stat_tracker'
require_relative './tables/team_table'
require_relative './tables/game_table'
require_relative './tables/game_team_tables'


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
}

stat_tracker = StatTracker.from_csv(locations)
p stat_tracker.most_accurate_team('20142015')
