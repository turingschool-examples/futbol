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
    games = GameStatistics.from_csv(location[:games])

    new(games) #, league_statistics, season_statistics)
  end

  def highest_total_score
    @game_statistics.highest_total_score
  end

  def lowest_total_score
    @game_statistics.lowest_total_score
  end

  def percentage_home_wins
    @game_statistics.percentage_home_wins
  end

  def percentage_away_wins
    @game_statistics.percentage_away_wins
  end
end
