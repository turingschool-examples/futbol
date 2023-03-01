class Coach
  attr_reader :name, :games_won, :games_lost
  def initialize(name)
    @name = name
    @games_lost = 0
    @games_won = 0
  end
end