require './lib/stat_tracker'

stat_tracker = StatTracker.from_csv({
  :games => "./data/games.csv",
  :teams => "./data/teams.csv",
  :game_teams  => "./data/game_teams.csv"
})

games_collection = stat_tracker.games
teams = stat_tracker.teams
game_teams_collection = stat_tracker.game_teams
