class Stats

    def initialize(locations)
        @games = CSV.open(locations[:games], headers: true).map { |info| Game.new(info) }
        @teams = CSV.open(locations[:teams], headers: true).map { |info| Team.new(info) }
        @game_teams = CSV.open(locations[:game_teams], headers: true).map { |info| GameTeam.new(info) }
        require 'pry'; binding.pry
    end
end