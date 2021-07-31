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
    @games_manager.favorite_opponent(team_id)
  end

  def rival(team_id)
    @games_manager.rival(team_id)
  end
end
