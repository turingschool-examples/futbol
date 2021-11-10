# require_relative './lib/stat_tracker'
require_relative './game_manager'
require_relative './game_teams_manager'
require_relative './game_teams'
require_relative './games'
require_relative './team_manager'
require_relative './teams'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games = GameManager.new(locations[:games])
    @teams = TeamManager.new(locations[:teams])
    @game_teams = GameTeamsManager.new(locations[:game_teams])
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

  def best_offense
    @game_teams.best_offense
  end

  def worst_offense
    @game_teams.worst_offense
  end

  def highest_scoring_visitor
    @game_teams.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_teams.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_teams.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_teams.lowest_scoring_home_team
  end
  
  def most_goals_scored(team_id)
    @game_teams.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_teams.fewest_goals_scored(team_id)
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end

  def count_of_teams
    @teams.count_of_teams
  end

  def average_win_percentage(team_id)
    @game_teams.average_win_percentage(team_id.to_i)
  end

  def most_tackles(season)
    @game_teams.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_teams.fewest_tackles(season)
  end

  def team_info(team_id)
    @teams.team_info(team_id)
  end
end
