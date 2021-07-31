class GeneralManager
  attr_reader :teams_manager,
              :games_manager,
              :game_teams_manager

  def initialize(locations)
    @teams_manager = TeamsManager.new(locations[:teams])
    @games_manager = GamesManager.new(locations[:games])
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams])
  end

  def team_info(team_id)
    @teams_manager.team_info(team_id)
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def highest_total_score
    @games_manager.highest_total_score
  end

  def lowest_total_score
    @games_manager.lowest_total_score
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
    @games_manager.highest_scoring_home_team
  end

  def lowest_scoring_home_team
    @games_manager.lowest_scoring_home_team
  end

  def highest_scoring_visitor
    @games_manager.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @games_manager.lowest_scoring_visitor
  end

  def favorite_opponent(team_id)
    id = @games_manager.favorite_opponent(team_id)
    @teams_manager.team_by_id(id)
  end

  def rival(team_id)
    id = @games_manager.rival(team_id)
    @teams_manager.team_by_id(id)
  end

  def winningest_coach(season)
    @game_teams_manager.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams_manager.worst_coach(season)
  end

  def most_accurate_team(season)
    id = @game_teams_manager.most_accurate_team(season)
    @teams_manager.team_by_id(id)
  end

  def least_accurate_team(season)
    id = @game_teams_manager.least_accurate_team(season)
    @teams_manager.team_by_id(id)
  end

  def most_tackles(season)
    id = @game_teams_manager.most_tackles(season)
    @teams_manager.team_by_id(id)
  end

  def fewest_tackles(season)
    id = @game_teams_manager.fewest_tackles(season)
    @teams_manager.team_by_id(id)
  end

  def best_season(team_id)
    @game_teams_manager.best_season(team_id)
  end

  def worst_season(team_id)
    @game_teams_manager.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_teams_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_teams_manager.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_teams_manager.fewest_goals_scored(team_id)
  end

  def best_offense
    id = @game_teams_manager.best_offense
    @teams_manager.team_by_id(id)
  end

  def worst_offense
    id = @game_teams_manager.worst_offense
    @teams_manager.team_by_id(id)
  end
end
