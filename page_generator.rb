require './lib/stat_tracker'
require 'erb'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
erb_file = './site/index.html.erb'
html_file = './site/index.html'
html_contents = File.read(erb_file)
renderer = ERB.new(html_contents)
result = renderer.result()

File.open(html_file, 'w') do |html_line|
  html_line.write(result)
end
