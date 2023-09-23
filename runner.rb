
require_relative 'spec_helper'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


stat_tracker = StatTracker.from_csv(locations)
# averagegoals = stat_tracker.average_goals_by_season
# require 'pry'; binding.pry

# stat_tracker = StatTracker.from_csv(locations)

stat_tracker = StatTracker.new(locations)

highest_scoring_game = stat_tracker.highest_total_score[0]

highest_scoring_playoff_game = stat_tracker.highest_total_score[1]

lowest_scoring_game = stat_tracker.lowest_total_score[0]

lowest_scoring_playoff_game = stat_tracker.lowest_total_score[1]

require 'pry'; binding.pry

