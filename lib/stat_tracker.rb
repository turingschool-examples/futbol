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
    # @game_stats = GameStats.new(locations)
    # @league_stats = LeagueStats.new(locations)
    @season_stats = SeasonStats.new(locations)
    # @team_stats = TeamStats.new(locations)
  end

   ################## Game Statisics ##################

  def highest_total_score
  end

  def lowest_total_score
  end

  def total_scores
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

  def season_goals(season)
  end

   ################## League Statisics ##################

  def count_of_teams
  end

  def team_id_all_goals
  end

  def team_goal_avg(team_all_goals_hash)
  end

  def best_team_avg(id)
  end

  def best_offense
  end

  def worst_offense
  end

  def away_team_goals
  end

  def home_team_goals
  end

  def avg_team_goals(team_goals_hash)
  end

  def team_name(id)
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

  def determine_coach_ratios(season)
    season_stats.determine_coach_ratios(season)
  end 

  def list_gameteams_from_particular_season(season)
    season_stats.list_gameteams_from_particular_season(season)
  end 

  def list_games_per_season(season)
    season_stats.list_games_per_season(season)
  end

  def coach_victory_percentage_hash(games_in_season)
    season_stats.coach_victory_percentage_hash(games_in_season)
  end 

  def determine_sorted_ratio(hash)
    season_stats.determine_sorted_ratio(hash)
  end

  def most_accurate_team(season)
    season_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    season_stats.least_accurate_team(season)
  end

  def all_games_by_season
    season_stats.all_games_by_season
  end

  def team_goals_shots_by_season(season)
    season_stats.team_goals_shots_by_season(season)
  end

  def team_ratios_by_season(hash)
    season_stats.team_ratios_by_season(hash)
  end

  def team_name(id)
    season_stats.team_name(id)
  end

  def most_tackles(season)
    season_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    season_stats.fewest_tackles(season)
  end

  def all_games_by_season
    season_stats.all_games_by_season
  end

  def gather_tackles_by_team(season)
    season_stats.gather_tackles_by_team(season)
  end

 ################## Team Statisics ##################
 
  def team_info(team_id)
  end

  def best_season(team_id)
  end 

  def worst_season(team_id)
  end

  def ordered_season_array(team_id)
  end

  def find_relevant_game_teams_by_teamid(team_id)
  end 

  def find_corresponding_games_by_gameteam(relevant_game_teams)
  end
   
  def group_by_season(relevant_games, relevant_game_teams)
  end 

  def order_list(hash_seasons)
  end

  def average_win_percentage(team_id)
  end

  def most_goals_scored(team_id) 
  end

  def fewest_goals_scored(team_id)
  end 

  def create_goals_array(relevant_games)
  end

  def favorite_opponent(team_id)
  end

  def rival(team_id)
  end

  def sorted_array_of_opponent_win_percentages(team_id)
  end

  def find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
  end 

  def hashed_info(relevant_games, relevant_game_teams, team_id)
  end

  def determine_game_outcome(game, relevant_game_teams) 
  end

  def accumulate_hash(hash)
  end

  def sort_based_on_value(array)
  end

  def determine_team_name_based_on_team_id(result_id)
  end
end