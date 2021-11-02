require 'csv'
class StatTracker
  attr_reader :game_data,
              :team_data,
              :game_team_data

  def initialize(game_data, team_data, game_team_data)
    @game_data      = game_data
    @team_data      = team_data
    @game_team_data = game_team_data
  end

  def self.from_csv(locations)
    game_data = CSV.read(locations[:games], headers: true)
    team_data = CSV.read(locations[:teams], headers: true)
    game_team_data = CSV.read(locations[:game_teams], headers: true)
    self.new(game_data, team_data, game_team_data)
  end

end
