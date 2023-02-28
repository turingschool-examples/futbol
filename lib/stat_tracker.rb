require 'csv'
class StatTracker
  attr_reader :games_data,
              :game_team_data,
              :team_data

  def initialize(games_data, game_team_data, team_data)
    @games_data = games_data
    @game_team_data = game_team_data
    @team_data = team_data
  end

  def self.from_csv(locations)
    games_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    team_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    StatTracker.new(games_data, game_team_data, team_data)
  end
end

# games_data.each do |row|
#   game_id = row[:game_id]
# end