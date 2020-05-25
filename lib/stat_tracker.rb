class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(data)
    @games = data[:games]
    @teams = data[:teams]
    @game_teams = data[:game_teams]
  end

  def self.from_csv(data)
    StatTracker.new(data)
  end

  # GAME STATISTICS

  # LEAGUE STATISTICS

  # SEASON STATISTIC

  # TEAM STATISTICS

end
