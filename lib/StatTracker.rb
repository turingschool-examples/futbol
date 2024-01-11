class StatTracker
  attr_reader :game_statistics
  # :league_statistics,
  # :season_statistics

  def initialize(game_statistics) #, league_statistics, season_statistics)
    @game_statistics = game_statistics
    # @league_statistics = league_statistics
    # @season_statistics = season_statistics
  end

  def self.from_csv(location)
    game_statistics = GameStatistics.create_game_stats(location[:games])


    new(game_statistics) #, league_statistics, season_statistics)
  end

  def highest_total_score
    @game_statistics.highest_total_score
  end

end
