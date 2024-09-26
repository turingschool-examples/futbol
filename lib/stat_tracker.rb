require_relative 'teams_manager'
require_relative 'games_manager'
require_relative 'game_teams_manager'

class StatTracker
  attr_reader :teams_manager, :games_manager, :game_teams_manager

  def initialize(locations)
    @teams_manager = TeamsManager.new(locations[:teams])
    @games_manager = GamesManager.new(locations[:games])
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def format_team_info(team)
    {
      'team_id' => team.team_id,
      'franchise_id' => team.franchise_id,
      'team_name' => team.team_name,
      'abbreviation' => team.abbreviation,
      'link' => team.link
    }
  end

  def team_info(team_id)
    format_team_info(@teams_manager.team_info(team_id))
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def highest_total_score
    @games_manager.game_score_results(:max)
  end

  def lowest_total_score
    @games_manager.game_score_results(:min)
  end

  def count_of_games_by_season
    @games_manager.count_of_games_by_season
  end

  def average_goals_by_season
    @games_manager.average_goals_by_season
  end

  def average_goals_per_game
    @games_manager.average_goals_per_game
  end

  def highest_scoring_home_team
    @teams_manager.team_by_id(@games_manager.team_scores(:home, :max))
  end

  def lowest_scoring_home_team
    @teams_manager.team_by_id(@games_manager.team_scores(:home, :min))
  end

  def highest_scoring_visitor
    @teams_manager.team_by_id(@games_manager.team_scores(:away, :max))
  end

  def lowest_scoring_visitor
    @teams_manager.team_by_id(@games_manager.team_scores(:away, :min))
  end

  def favorite_opponent(team_id)
    @teams_manager.team_by_id(@games_manager.opponent_results(team_id, :min))
  end

  def rival(team_id)
    @teams_manager.team_by_id(@games_manager.opponent_results(team_id, :max))
  end

  def winningest_coach(season)
    @game_teams_manager.coach_results(season, :max)
  end

  def worst_coach(season)
    @game_teams_manager.coach_results(season, :min)
  end

  def most_accurate_team(season)
    @teams_manager.team_by_id(@game_teams_manager.accuracy_results(season, :max))
  end

  def least_accurate_team(season)
    @teams_manager.team_by_id(@game_teams_manager.accuracy_results(season, :min))
  end

  def most_tackles(season)
    @teams_manager.team_by_id(@game_teams_manager.tackle_results(season, :max))
  end

  def fewest_tackles(season)
    @teams_manager.team_by_id(@game_teams_manager.tackle_results(season, :min))
  end

  def best_season(team_id)
    @game_teams_manager.season_results(team_id, :max)
  end

  def worst_season(team_id)
    @game_teams_manager.season_results(team_id, :min)
  end

  def average_win_percentage(team_id)
    @game_teams_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_teams_manager.goal_results(team_id, :max)
  end

  def fewest_goals_scored(team_id)
    @game_teams_manager.goal_results(team_id, :min)
  end

  def best_offense
    @teams_manager.team_by_id(@game_teams_manager.offense_results(:max))
  end

  def worst_offense
    @teams_manager.team_by_id(@game_teams_manager.offense_results(:min))
  end

  def percentage_home_wins
    @game_teams_manager.percentage_hoa_wins(:home)
  end

  def percentage_visitor_wins
    @game_teams_manager.percentage_hoa_wins(:away)
  end

  def percentage_ties
    @game_teams_manager.percentage_ties
  end
end
