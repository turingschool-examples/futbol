require 'csv'
class StatTracker
    attr_reader :game_teams,
                :games,
                :teams

    def initialize(locations)
      @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
      @games = CSV.read locations[:games], headers: true, header_converters: :symbol
      @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    end

    def self.from_csv(locations)
      StatTracker.new(locations)
    end
end
