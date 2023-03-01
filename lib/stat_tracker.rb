require 'csv'
require_relative 'game'
require_relative 'team'

class StatTracker 
  #include modules

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  attr_reader :game_data, :team_data, :game_teams_data

  def initialize(locations)
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @team_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
end
