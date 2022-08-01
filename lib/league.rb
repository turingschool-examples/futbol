class League
  attr_accessor :seasons,
                :games,
                :teams
  def initialize
    @seasons = []
    @games = []
    @teams = []
  end
end