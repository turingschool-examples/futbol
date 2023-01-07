require 'csv'
require './lib/stat_tracker'


game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

stat_tracker.most_tackles("20122013")

stat_tracker.group_season_tackles

# puts stat_tracker.percentage_home_wins
