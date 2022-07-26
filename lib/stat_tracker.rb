require 'csv'

class StatTracker

  def initialize #(game, team, game_teams)
    @games = []
    @teams = []
    @game_teams = []
  end

    def self.from_csv(locations)
      @game = CSV.table(locations[:games], headers: true, header_converters: :symbol)
      @team = CSV.table(locations[:teams], headers: true, header_converters: :symbol)
      @game_teams = CSV.table(locations[:game_teams], headers: true, header_converters: :symbol)
      StatTracker.new
      require "pry"; binding.pry
    end
end
