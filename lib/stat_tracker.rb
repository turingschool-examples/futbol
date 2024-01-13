require './lib/game'
require './lib/game_team'
require './lib/team'
require './lib/game_statistics'
require './lib/league_statistics'
require './lib/season_statistics'

class StatTracker
  attr_reader :game_statistics,
              :league_statistics,
              :season_statistics

  def initialize(game_statistics, league_statistics, season_statistics)
    @game_statistics = game_statistics
    @league_statistics = league_statistics
    @season_statistics = season_statistics
  end

  def self.from_csv(location)
    games_statistics = GameStatistics.from_csv(location[:games])
    league_statistics = LeagueStatistics.from_csv(location[:teams], location[:game_teams])
    season_statistics = SeasonStatistics.from_csv(location[:games], location[:game_teams], location[:teams])

    new(games_statistics, league_statistics, season_statistics)
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

  def percentage_ties
    @game_statistics.percentage_ties
  end

  def count_of_games_by_season
    @game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    @game_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @game_statistics.average_goals_by_season
  end

  def count_of_teams
    @league_statistics.count_of_teams
  end

  def best_offense
    @league_statistics.best_offense
  end

  def worst_offense
    @league_statistics.worst_offense
  end

  def highest_scoring_visitor
    @league_statistics.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_statistics.highest_scoring_home_team
  end

  def lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team
  end

  def worst_coach(season)
    @season_statistics.worst_coach(season)
  end

  def winningest_coach(season)
    @season_statistics.winningest_coach(season)
  end

  def most_accurate_team(season)
    @season_statistics.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_statistics.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_statistics.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_statistics.fewest_tackles(season)
  end
end
