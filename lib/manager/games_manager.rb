class GamesManager
  attr_reader :location,
              :parent,
              :games

  def self.get_data(location, parent)
    games = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row, self)
    end
    new(location, parent, games)
  end

  def initialize(location, parent, games)
    @location = location
    @parent = parent
    @games = games
  end

  # def highest_total_score
  #   most = 0
  #   CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
  #     total = row[:away_goals].to_i + row[:home_goals].to_i
  #     most = total if total > most
  #   end
  #   most
  # end
end