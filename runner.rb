require_relative './lib/stat_tracker'

game_path = './data/games_dummy.csv'
team_path = './data/teams_dummy.csv'
game_teams_path = './data/game_teams_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

ted_lasso = StatTracker.from_csv(locations)
# ted_lasso will hold the value of a single instance
# of the StatTracker class. That instance will hold all
# the data we've opened within it. In effect, ted_lasso
# holds all of our data, and will have all our methods
# called to it.
# require 'pry'; binding.pry

ted_lasso.percentage_ties
