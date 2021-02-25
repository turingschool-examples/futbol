require 'CSV'

class GamesManager
  attr_reader :games

  def initialize(locations, stat_tracker)
    @locations = locations
    @stat_tracker = stat_tracker
    @games = []
  end

  # def create_games(location)
  #   result = CSV.parse(File.read(location), headers: true)
  #   result.map do |row|
  #     @games << Game.new(row, self)
  #   end
  # end

end
