require './lib/stat_tracker'
require 'erb'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path,
            }

stat_tracker = StatTracker.from_csv(locations)
erb_file = File.expand_path('./website.html.erb', File.dirname(__FILE__))
website = ERB.new(File.read(erb_file)).result(binding)

File.open('./website/website.html', 'w') { |file| file.write(website) }