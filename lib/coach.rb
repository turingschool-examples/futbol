class Coach
  attr_reader :name
  attr_accessor :games,
                :wins
  def initialize(name)
    @name = name
    @games = 0
    @wins = 0
  end

end