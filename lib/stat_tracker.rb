require_relative './game_collection'
require_relative './team_collection'
require_relative './game_team_collection'

class StatTracker
  attr_reader :game_repo, :team_repo, :game_teams_repo

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]
    StatTracker.new(game_path, teams_path, game_teams_path)
  end

  def initialize(game_path, teams_path, game_teams_path)
    @team_repo = TeamCollection.new(teams_path)
    @game_teams_repo = GameTeamCollection.new(game_teams_path)
    @game_repo = GameCollection.new(game_path)
  end

  def count_of_games_by_season
    @game_repo.find_count_of_game_by_season
  end

  def average_goals_per_game
    @game_repo.find_average_goals_per_game
  end

  def highest_total_score
    @game_repo.find_highest_total_score
  end

  def lowest_total_score
    @game_repo.find_lowest_total_score
  end

  def average_goals_by_season
    @game_repo.find_average_goals_by_season
  end

  def biggest_blowout
    @game_repo.calculate_goal_differences
  end

  def percentage_home_wins
    @game_repo.find_percentage_home_wins
  end

  def percentage_visitor_wins
    @game_repo.find_percentage_away_wins
  end

  def percentage_ties
    @game_repo.find_percentage_of_ties
  end

  def count_of_teams
    @team_repo.total_teams
  end

  def highest_scoring_home_team
    highest_scoring_home_team_id = @game_repo.find_highest_average_home_score_per_home_game.to_s
    @team_repo.find_team_name_by_id(highest_scoring_home_team_id)
  end

  def highest_scoring_visitor
    highest_scoring_away_team_id = @game_repo.find_highest_average_away_score_per_away_game.to_s
    @team_repo.find_team_name_by_id(highest_scoring_away_team_id)
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team_id = @game_repo.find_lowest_average_home_score_per_home_game.to_s
    @team_repo.find_team_name_by_id(lowest_scoring_home_team_id)
  end

  def lowest_scoring_visitor
    lowest_scoring_away_team_id = @game_repo.find_lowest_average_away_score_per_away_game.to_s
    @team_repo.find_team_name_by_id(lowest_scoring_away_team_id)

  def winningest_team
    id = @game_teams_repo.winningest_team_id
    @team_repo.find_name_by_id(id)
  end
end
