require './lib/stat_tracker'

# commenting out old file paths -- so we have them for future use - dummy lines below will go away
# game_path = './data/games.csv'
# team_path = './data/teams.csv'
# game_teams_path = './data/game_teams.csv'

game_path = './data/games_dummy.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
