# runner.rb
require 'csv'
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

CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
  game_id = row[:game_id]
  season = row[:season]
  type = row[:type]
  date_time = row[:date_time]
  away_team_id = row[:away_team_id]
  home_team_id = row[:home_team_id]
  away_goals= row[:away_goals]
  home_goals = row[:home_goals]
  venue = row[:venue]
  venue_link = row[:venue_link]
  # game = Games.new(game_id, season, type, date_time, away_team_id, home_team_id,)
end

CSV.foreach(team_path, headers: true, header_converters: :symbol) do |row|
  team_id = row[:team_id]
  franchise_id = row[:franchiseId]
  team_name = row[:teamName]
  abbreviation = row[:abbreviation]
  stadium = row[:stadium]
  link = row[:link]
  # team = Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
end

CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
  game_id = row[:game_id]
  team_id = row[:team_id]
  hoa = row[:hoa]
  result = row[:result]
  settled_in = row[:settled_in]
  head_coach = row[:head_coach]
  goals = row[:goals]
  shots = row[:shots]
  tackles = row[:tackles]
  pim = row[:pim]
  pp_opportunities = row[:powerplayopportunities]
  pp_goals = row[:powerplaygoals]
  face_off_win_percentage = row[:faceOffWinPercentage]
  giveaways = row[:giveaways]
  takeaways = row[:takeaways]
  # game_teams = GameTeams.new()
  end

# rows = []
# CSV.foreach(game_path) do |row|
#   rows << row # require 'pry'; binding.pry
# end
#
# p rows



require 'pry'; binding.pry
