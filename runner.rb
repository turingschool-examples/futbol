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
<<<<<<< HEAD

# require 'pry'; binding.pry
=======
>>>>>>> bc640c8815fa421c33ac24ed4842367f05b26174
