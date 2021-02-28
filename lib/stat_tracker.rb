require 'CSV'
require_relative './games_manager'
require_relative './teams_manager'
require_relative './game_teams_manager'

class StatTracker

  def initialize(games_path, team_path, game_team_path)
    @games = GamesManager.new(games_path)
    @teams = TeamsManager.new(team_path)
    @game_teams = GameTeamsManager.new(game_team_path)
  end

  def self.from_csv(data_locations)
    games_path = data_locations[:games]
    teams_path = data_locations[:teams]
    game_teams_path = data_locations[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  ####### Game Stats ########
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

  ###########################

  ###### Team Stats #########

  def team_info(team_id)
    @teams.team_info(team_id)
  end

  def best_season(team_id)
    @games.best_season(team_id)
  end

  def worst_season(team_id)
    @games.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @games.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @games.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @games.fewest_goals_scored(team_id)
  end


  ###########################

  ###### League Stats #######
  def count_of_teams
    @teams.count_of_teams
  end

  def best_offense
    @teams.get_team_name(@game_teams.best_offense)
  end

  def worst_offense
    @teams.get_team_name(@game_teams.worst_offense)
  end

  def highest_scoring_visitor
    @teams.get_team_name(@games.highest_scoring_visitor)
  end

  def lowest_scoring_visitor
    @teams.get_team_name(@games.lowest_scoring_visitor)
  end


  ###########################

  ###### Season Stats #######

  def most_tackles(season)
    season_games = @games.get_season_games(season)
    tackle_hash = @game_teams.get_team_tackle_hash(season_games)
    team_id = tackle_hash.key(tackle_hash.values.max)
    @teams.get_team_name(team_id)
  end

  def fewest_tackles(season)
    season_games = @games.get_season_games(season)
    tackle_hash = @game_teams.get_team_tackle_hash(season_games)
    team_id = tackle_hash.key(tackle_hash.values.min)
    @teams.get_team_name(team_id)
  end

  def most_accurate_team(season)
    season_games = @games.get_season_games(season)
    score_ratios = @game_teams.score_ratios_hash(season_games)
    team_id = score_ratios.key(score_ratios.values.max)
    @teams.get_team_name(team_id)
  end

  def least_accurate_team(season)
    season_games = @games.get_season_games(season)
    score_ratios = @game_teams.score_ratios_hash(season_games)
    team_id = score_ratios.key(score_ratios.values.min)
    @teams.get_team_name(team_id)
  end

  def winningest_coach(season)
    @game_teams.winningest_coach(@games.get_season_games(season))
  end

  def worst_coach(season)
    @game_teams.worst_coach(@games.get_season_games(season))
  end

  ###########################

end
