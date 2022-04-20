require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'

class CSVReader
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    # require 'pry'; binding.pry
    @game_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_team_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @games = Game.fill_game_array(@game_data)
    @teams = Team.fill_team_array(@team_data)
    @game_teams = GameTeams.fill_game_teams_array(@game_team_data)
  end
end
