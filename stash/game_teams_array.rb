require 'pry'
require 'CSV'

games_teams_array = []
CSV.foreach("./data/game_teams.csv", headers: true, header_converters: :symbol) do |row|
  game_teams_hash = {}
  game_teams_hash[:game_id] = row[:game_id].to_i
  game_teams_hash[:team_id] = row[:team_id].to_i
  game_teams_hash[:HoA] = row[:HoA]
  game_teams_hash[:result] = row[:result]
  game_teams_hash[:settled_in] = row[:settled_in]
  game_teams_hash[:head_coach] = row[:head_coach]
  game_teams_hash[:goals] = row[:goals].to_i
  game_teams_hash[:shots] = row[:shots].to_i
  game_teams_hash[:tackles] = row[:tackles].to_i
  game_teams_hash[:pim] = row[:pim].to_i
  game_teams_hash[:powerPlayOpportunitites] = row[:powerPlayOpportunitites].to_i
  game_teams_hash[:powerPlayGoals] = row[:powerPlayGoals].to_i
  game_teams_hash[:faceOffWinPercentage] = row[:faceOffWinPercentage].to_i
  game_teams_hash[:giveaways] = row[:giveaways].to_i
  game_teams_hash[:takeaways] = row[:takeaways].to_i
  binding.pry
games_teams_array << game_teams_hash
end
