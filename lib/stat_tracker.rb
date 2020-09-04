class StatTracker

  def initialize

  end

  def self.from_csv(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]
    stat_tracker = self.new
  end

end
