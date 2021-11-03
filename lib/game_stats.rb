require 'csv' 

class GameStats
    attr_reader :games 

    def initialize(file)
        @games = self.format(file)
        require 'pry'; binding.pry
    end

    def format(file)
        game_file = CSV.read(file, headers: true, header_converters: :symbol)
        game_file.map do |row|
            Game.new(row)
        end
    end
end