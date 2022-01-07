require 'csv'

class Stats 
  attr_reader :games, :teams, :game_teams, :home_goals, :away_goals, :season

  def initialize(locations)
    # @games = CSV.parse(File.read(locations[:games]), headers: true).map {|row| Game.new(row)}
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol

  end
end
