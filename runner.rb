require 'csv'
require './lib/stat_tracker'

teams = CSV.read("./data/teams.csv")
games = CSV.read("./data/games.csv")
games_teams = CSV.read("./data/games.csv")

stat_tracker = StatTracker.new(games, teams, games_teams)
