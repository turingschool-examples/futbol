require 'csv'
require_relative 'csv_loader.rb'
require_relative 'games'
require_relative 'league'
require_relative 'season_stats'
require_relative 'team_stats'

class StatTracker

  def initialize (games, teams, game_teams)
    @games = Games.new(games, teams, game_teams)
    @league = League.new(games, teams, game_teams)
    @season_stats = SeasonStats.new(games, teams, game_teams)
    @team_stat = Team.new(games, teams, game_teams)
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games])
    teams = CSV.table(locations[:teams])
    game_teams = CSV.table(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def percentage_home_wins 
    @games.percentage_home_wins
  end

  def percentage_visitor_wins
    @games.percentage_visitor_wins
  end

  def percentage_ties 
    @games.percentage_ties
  end

  def count_of_games_by_season
    @games.count_of_games_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def average_goals_by_season
  @games.average_goals_by_season
  end

  def count_of_teams
    @league.count_of_teams
  end

  def best_offense 
    @league.best_offense
  end

  def worst_offense 
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  def highest_scoring_home_team 
    @league.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  def lowest_scoring_home_team 
    @league.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @season_stats.winningest_coach(season)
  end

  def worst_coach(season)
    @season_stats.worst_coach(season)
  end

  def most_accurate_team(season_id)
    @season_stats.most_accurate_team(season_id)
  end

  def least_accurate_team(season)
    @season_stats.least_accurate_team(season)
  end

  def most_tackles(season_id)
    @season_stats.most_tackles(season_id)

  def fewest_tackles(season_id)
    @season_stats.fewest_tackles(season_id)
  end

  def team_info(team_id)
    @team_stat.team_info(team_id)
  end

   def best_season(team_id)
   @team_stat.best_season(team_id)
  end

  def worst_season(team_id)
    @team_stat.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_stat.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id) 
    @team_stat.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id) 
    @team_stat.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_stat.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team_stat.rival(team_id)
  end
end
