# require_relative 'stat_tracker'
require 'csv'
require_relative 'games'
require_relative 'game_teams'
require_relative 'league'
class Banana
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  end
end