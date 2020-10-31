require 'CSV'
require './lib/games_repo'
require './lib/teams_repo'
require './lib/game_teams_repo'

class StatTracker
  attr_reader :games_repo, :teams_repo, :game_teams_repo

  def initialize(locations)
    @games_repo = GamesRepo.new(locations[:game_path], self)
    @teams_repo = TeamsRepo.new(locations[:teams_path], self)
    @game_teams_repo = GameTeamsRepo.new(locations[:game_teams_path], self)

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def count_of_teams
    @teams_repo.count_of_teams
  end

  def best_offense
    id = @game_teams_repo.highest_average_goals
    @teams_repo.team_name(id)
  end

  def worst_offense
    id = @game_teams_repo.lowest_average_goals
    @teams_repo.team_name(id)
  end

  def highest_total_score
    @games_repo.highest_total_goals
  end

  def lowest_total_score
    @games_repo.lowest_total_goals
  end

  def count_of_games_by_season
    @games_repo.count_of_games_by_season
  end

  def average_goals_per_game
    @games_repo.average_goals_per_game
  end

  def average_goals_by_season
    @games_repo.average_goals_by_season
  end

  def percentage_home_wins
    @game_teams_repo.percentage_wins("home")
  end

  def percentage_visitor_wins
    @game_teams_repo.percentage_wins("away")
  end

  def percentage_ties
    @game_teams_repo.percentage_ties
  end

  def highest_scoring_visitor
    id = @game_teams_repo.highest_average_hoa_goals("away")
    @teams_repo.team_name(id)
  end

  def highest_scoring_home_team
    id = @game_teams_repo.highest_average_hoa_goals("home")
    @teams_repo.team_name(id)
  end

  def lowest_scoring_visitor
    id = @game_teams_repo.lowest_average_hoa_goals("away")
    @teams_repo.team_name(id)
  end

  def lowest_scoring_home_team 
    id = @game_teams_repo.lowest_average_hoa_goals("home")
    @teams_repo.team_name(id)
  end
end
