class SeasonStats
  attr_reader :teams, :game_stats

  def initialize(teams, game_stats)
    @teams = teams
    # @games = games
    @game_stats = game_stats
  end

end
