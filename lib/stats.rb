class Stats

    def initialize
        puts 'test'
        @games = CSV.foreach('./data/games.csv', headers: true).map do |info|
            Game.new(info)
        end
        require 'pry'; binding.pry
    end
end
stats = Stats.new