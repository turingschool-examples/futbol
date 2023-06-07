class Game
  
  def initialize
    @games = CSV.read('./data/games.csv', headers: true, header_converters: :symbol)
  end

  def percentage_ties
    ties = @games.find_all do |game|
      game[:home_goals] == game[:away_goals]
    end
    ties.count.to_f / @games.count.to_f
  end
  
end
