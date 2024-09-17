# runner.rb
require './lib/stat_tracker'
require './lib/game_team_factory'
require './lib/game_factory'
require './lib/teams_factory'

game_path = './data/games_test.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_team_test.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

# stat_tracker = StatTracker.from_csv(locations)
game_team1 = GameTeamFactory.new
game_team1.create_game_teams(game_teams_path)

games1 = GameFactory.new
games1.create_games(game_path)

teams1 = Teams_factory.new
teams1.create_teams(team_path)

require 'pry'
binding.pry
