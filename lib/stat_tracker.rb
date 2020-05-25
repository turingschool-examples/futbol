class StatTracker
  def initialize(data)
    @games = data[:games]
    @teams = data[:teams]
    @game_teams = data[:game_teams]
  end

  def self.from_csv(data)
    self.new(data)
  end
end
