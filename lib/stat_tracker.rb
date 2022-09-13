class StatTracker
  attr_reader :teams,
              :games,
              :game_teams

  def initialize
    @teams = []
    @games = []
    @game_teams = []
  end

  def self.from_csv()
  end
end