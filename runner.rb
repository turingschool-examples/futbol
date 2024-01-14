require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
<<<<<<< HEAD

=======
>>>>>>> c3db4ee8b6f72d93866cec4c576bb5e306baa244

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
