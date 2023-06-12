require './lib/stat_tracker'
require "csv"

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

p "The winningest coach for season 20132014 is #{stat_tracker.winningest_coach("20132014")}." 

p "The lowest scoring visiting team is #{stat_tracker.lowest_scoring_visitor}."

p "The team with the least accuracy for season 20132014 is #{stat_tracker.least_accurate_team("20132014")}."

p "There are #{stat_tracker.count_of_teams} teams represented in the CSV data."

p "The count of games by season is #{stat_tracker.count_of_games}."
