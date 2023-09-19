require 'csv'

class StatTracker
  attr_reader :game_team_data, :game_data, :team_data
  
  def initialize
    @game_team_data = CSV.open './data/games.csv', headers: true, header_converters: :symbol
    @game_data = game_data = CSV.open data[:games], headers: true, header_converters: :symbol
    @team_data = 
  end

  def self.from_csv(data)
    game_team_data = CSV.open data[:game_teams], headers: true, header_converters: :symbol
    game_data = CSV.open data[:games], headers: true, header_converters: :symbol
    team_data = CSV.open data[:teams], headers: true, header_converters: :symbol

    new(game_team_data, game_data, team_data)

    return game_team_data, game_data, team_data
  end
end