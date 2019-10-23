require './lib/stat_tracker'

stat_tracker = StatTracker.from_csv({
  :game_team     => "./data/game_teams.csv",
  :games => "./data/games.csv",
  :teams => "./data/teams.csv",
})

game_teams_collection = stat_tracker.game_teams
games_collection = stat_tracker.games
teams = stat_tracker.teams
