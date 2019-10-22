require_relative './game'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new

    games = []
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      require "pry"; binding.pry
      games << Game.new(row)
    end

    StatTracker.new
  end
end
