require 'csv'
require_relative './season_stats'

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

  def highest_total_score
  end

  def lowest_total_score
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end
 
  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game 
  end
 
  def average_goals_by_season
  end

   ################## League Statisics ##################

  def count_of_teams
  end

  def best_offense
  end

  def worst_offense
  end

  def highest_scoring_visitor
  end
 
  def highest_scoring_home_team
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
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
  end

  def best_season(team_id)
  end 

  def worst_season(team_id)
  end

  def average_win_percentage(team_id)
  end

  def most_goals_scored(team_id) 
  end

  def fewest_goals_scored(team_id)
  end 

  def favorite_opponent(team_id)
  end

  def rival(team_id)
  end
end