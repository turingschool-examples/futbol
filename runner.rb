require 'CSV'
require './lib/stat_tracker'

require './lib/stat_tracker'
stat_tracker = StatTracker.from_csv({
 :game_teams  => "./data/game_teams.csv",
 :games => "./data/games.csv",
 :teams => "./data/teams.csv",
})
# game_teams_collection = stat_tracker.game_teams
game_collection = stat_tracker.game
# teams = stat_tracker.teams




