require 'CSV'
require_relative '../lib/game_manager'
require_relative '../lib/team_manager'
require_relative '../lib/game_teams_manager'
require_relative '../lib/modable'
require_relative '../lib/season_stats'
require_relative '../lib/stat_tracker_helper'



class StatTracker
  include Modable, SeasonStats, StatTrackerHelper

  attr_reader :game_manager, :game_teams_manager, :team_manager
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    @game_teams_manager = GameTeamsManager.new(game_teams_path)
    @game_manager = GameManager.new(game_path)
    @team_manager = TeamManager.new(team_path)
  end


  def highest_total_score #game_manager -> highest_total_score method
    @game_manager.highest_total_score
  end

  def lowest_total_score   #game_manager -> lowest_total_score method
    @game_manager.lowest_total_score
  end

  def percentage_home_wins #game_team_manager -> percentage_home_wins
    self.percentage_home_wins1
  end

  def percentage_visitor_wins #game_team_manager -> percentage_visitor_wins
    self.percentage_visitor_wins1
  end

  def count_of_games_by_season #game_manager -> count_of_games_by_season
    self.count_of_games_by_season1
  end

  def percentage_ties #game_team_manager -> percentage_ties
    self.percentage_ties1
  end

  def average_goals_per_game #game_manager -> average_goals_per_Game
    self.average_goals_per_game1
  end

  def average_goals_by_season #game_manager -> average_goals_by_season
    self.average_goals_by_season1
  end

  def team_info(id) #team_manager -> team_info(id)
    @team_manager.team_info(id)
  end

  def best_season(id) #game_manager -> best_season(id)
    @game_manager.best_season(id)
  end

  def worst_season(id) #game_manager -> worst_season(id)
    @game_manager.worst_season(id)
  end

  def average_win_percentage(id) #game_manager -> average_win_percentage(id)
    @game_manager.average_win_percentage(id)
  end

  def most_goals_scored(id) #game_manager -> most_goals_scored(id)
    @game_manager.most_goals_scored(id)
  end

  def fewest_goals_scored(id) #game_manager -> fewest_goals_scored(id)
    @game_manager.fewest_goals_scored(id)
  end

  def favorite_opponent(id) #game_manager -> favorite_opponent(id)
    self.favorite_opponent1(id)
  end

  def rival(id) #game_manager -> rival
    self.rival3(id)
  end

  def count_of_teams #team_manager -> count_of_teams
    @team_manager.size
  end

  def best_offense #game_teams_manager -> best_offense
    self.best_offense1
  end

  def worst_offense #game_teams_manager -> worst_offense
    self.worst_offense1
  end

  def highest_visitor_team #game_teams_manager -> highest_visitor_team
    self.highest_visitor_team1
  end

  def lowest_visitor_team #game_teams_manager -> lowest_visitor_team
    self.lowest_visitor_team1
  end

  def lowest_home_team #game_teams_manager -> lowest_home_team
    @game_teams_array.lowest_home_team
  end
  #season stats start here (Drew's)
  def winningest_coach(season) #game_manager -> winningest coach
    self.winningest_coach2(season)
  end

  def worst_coach(season) #game_manager -> worst_coach
    self.worst_coach2(season)
  end

  def most_accurate_team(season) #game_manager -> most_accurate_team
    self.most_accurate_team3(season)
  end

  def highest_home_team #game_teams_manager -> highest_home_team
    self.highest_home_team1
  end

  def lowest_home_team #game_teams_manager -> lowest_home_team
    team = @game_teams_manager.lowest_home_team.first
    @team_manager.find_by_id(team).team_name
  end

  def least_accurate_team(season) #game_manager -> least_accurate_team
    self.least_accurate_team1(season)
  end

  def most_tackles(season) #game_manager -> most_tackles
    @all_games = @game_manager.games_by_season(season)
    self.most_tackles1(season)
  end

  def fewest_tackles(season) #game_manager -> fewest_tackles
  end
end
