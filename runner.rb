require './spec/spec_helper'
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
#  p stat_tracker.find_team_name_by_id(27)
# p stat_tracker.percentage_home_wins
# p stat_tracker.percentage_visitor_wins
# p stat_tracker.percentage_ties

# require 'pry'; binding.pry