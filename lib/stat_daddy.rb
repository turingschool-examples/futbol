require "csv"

class StatDaddy
  attr_reader :games,
    :teams,
    :gameteams

  def initialize(locations)
    @games = CSV.open(locations[:games], headers: true, header_converters: :symbol).map do |game|
      # Game.new(game)
    end
    @teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol).map do |team|
      # Team.new(team)
    end
    @gameteams = CSV.open(locations[:gameteams], headers: true, header_converters: :symbol).map do |gameteam|
      # GameTeam.new(gameteam)
    end
  end
end
