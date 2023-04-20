require 'csv'

class StatTracker 
  attr_reader :games, :teams, :game_teams

  def initialize(locations_details)
    @games = locations_details[:games]
    @teams = locations_details[:teams]
    @game_teams = locations_details[:game_teams]
  end

  def self.from_csv(locations)
    csv_team_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    csv_games_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    csv_game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    StatTracker.new({:game => csv_games_data, :game_team => csv_game_team_data, :team => csv_team_data})
  end
end