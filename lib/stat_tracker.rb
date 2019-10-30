require_relative './game_collection'
require_relative './team_collection'
require_relative './game_team_collection'
require_relative './goal_average_module'
require_relative './helper'


class StatTracker
  include GoalAverage
  include Helper
attr_reader :game_teams, :games, :teams

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @games = GameCollection.new(@game_path)
    @teams = TeamCollection.new(@team_path)
    @game_teams = GameTeamCollection.new(@game_teams_path)
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def biggest_blowout
    @games.biggest_blowout
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

  def goal_count_per_season
    @games.goal_count_per_season
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def count_of_teams
    @game_teams.count_of_teams
  end

end
