require_relative './game_statistics'
require_relative './league_statistics'
require_relative './team_statistics'
require_relative './season_statistics'
require 'CSV'
class StatTracker
  attr_reader :league_statistics, :game_statistics, :team_statistics, :season_statistics
  def initialize(data_files)
    @league_statistics = LeagueStatistics.new(data_files)
    @game_statistics = GameStatistics.new(data_files)
    @team_statistics = TeamStatistics.new(data_files)
    @season_statistics = SeasonStatistics.new(data_files)
  end

  def self.from_csv(data_files)
      StatTracker.new(data_files)
  end

  def highest_total_score
    @game_statistics.total_score(:high)
  end

  def lowest_total_score
    @game_statistics.total_score(:low)
  end

  def percentage_home_wins
    @game_statistics.percentage_outcomes("home")
  end

  def percentage_visitor_wins
    @game_statistics.percentage_outcomes("away")
  end

  def percentage_ties
    @game_statistics.percentage_outcomes("tie")
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
    @league_statistics.best_worst_offense(:high)
  end

  def worst_offense
    @league_statistics.best_worst_offense(:low)
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

  def team_info(team_id)
    @team_statistics.team_info(team_id)
  end

  def best_season(team_id)
    @team_statistics.season_best_and_worst(team_id, :high)
  end

  def worst_season(team_id)
    @team_statistics.season_best_and_worst(team_id, :low)
  end

  def average_win_percentage(team_id)
    @team_statistics.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_statistics.goals_scored_high_and_low(team_id, :high)
  end

  def fewest_goals_scored(team_id)
    @team_statistics.goals_scored_high_and_low(team_id, :low)
  end

  def favorite_opponent(team_id)
    @team_statistics.opponent_preference(team_id, :fav)
  end

  def rival(team_id)
    @team_statistics.opponent_preference(team_id, :rival)
  end

  def winningest_coach(season)
    @season_statistics.coach_win_loss_results(season, :high)
  end

  def worst_coach(season)
    @season_statistics.coach_win_loss_results(season, :low)
  end

  def most_tackles(season)
    @season_statistics.most_least_tackles(season, :high)
  end

  def fewest_tackles(season)
    @season_statistics.most_least_tackles(season, :low)
  end

  def most_accurate_team(season)
  @season_statistics.team_accuracy(season,:high)
  end

  def least_accurate_team(season)
  @season_statistics.team_accuracy(season, :low)
  end
end
