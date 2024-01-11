class StatTracker
  attr_reader :games_statistics,
  :league_statistics,
  :season_statistics

  def initialize(games_statistics, league_statistics, season_statistics)
    @games_statistics = games_statistics
    @league_statistics = league_statistics
    @season_statistics = season_statistics
  end

  def self.from_csv(location)
    games_statistics = GameStatistics.from_csv(location[:games])


    new(games_statistics, league_statistics, season_statistics)
  end

  def highest_total_score
    @games_statistics.highest_total_score
  end


end
