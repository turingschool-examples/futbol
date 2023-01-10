require 'csv'
require_relative './team_stats'
require_relative './season_stats'
require_relative './game_stats.rb'
require_relative './league_stats.rb'

class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats,
              :team_stats   
              
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_stats = GameStats.new(locations)
    @league_stats = LeagueStats.new(locations)
    @season_stats = SeasonStats.new(locations)
    @team_stats = TeamStats.new(locations)
  end

   ################## Game Statisics ##################

  def initialize(locations)
    @teamstats = TeamStats.new(locations)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end
 
  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game 
    @game_stats.average_goals_per_game
  end
 
  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

   ################## League Statisics ##################

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def away_team_goals
    @league_stats.away_team_goals
  end

  def home_team_goals
    @league_stats.home_team_goals
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end
 
  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

   ################## Season Statisics ##################

  def winningest_coach(season)
    season_stats.winningest_coach(season)
  end 

  def worst_coach(season)
    season_stats.worst_coach(season)
  end 

  def most_accurate_team(season)
    season_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    season_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    season_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    season_stats.fewest_tackles(season)
  end

  ################## Team Statisics ##################
 
  def team_info(team_id)
    teamstats.team_info("6")
  end

  def best_season(team_id)
    teamstats.best_season(team_id)
  end 

  def worst_season(team_id)
    teamstats.worst_season(team_id)
  end

  def most_goals_scored(team_id) 
    teamstats.most_goals_scored(team_id) 
  end

  def fewest_goals_scored(team_id)
    teamstats.fewest_goals_scored(team_id)
  end 

  def favorite_opponent(team_id)
    teamstats.favorite_opponent(team_id)
  end

  def rival(team_id)
    teamstats.rival(team_id)
  end

  def average_win_percentage(team_id)
    teamstats.average_win_percentage(team_id)
  end
end

