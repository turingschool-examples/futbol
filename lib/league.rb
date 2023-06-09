class League
  attr_reader :teams, :game
  
  def initialize(team, game)
    @teams = team
    @games = game
  end

end
