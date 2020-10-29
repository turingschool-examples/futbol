class GamesRepo
  attr_reader :parent, :games 
  
  def initialize(path, parent)
    @parent = parent 
    @games = create_games(path)
  end
end