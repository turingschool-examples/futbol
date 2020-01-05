require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'offense'
require_relative 'defense'

class StatTracker
  def self.from_csv(file_path)
    game_path = file_path[:games]
    team_path = file_path[:teams]
    game_team_path = file_path[:game_teams]

    StatTracker.new(game_path, team_path, game_team_path)
  end

  def initialize(game_path, team_path, game_team_path)
    Game.from_csv(game_path)
    Team.from_csv(team_path)
    GameTeam.from_csv(game_team_path)
  end

  def count_of_games_by_season
    Game.count_of_games_by_season
  end

  def average_goals_by_season
    Game.average_goals_by_season
  end

  def average_goals_per_game
    Game.average_goals_per_game
  end

  def percentage_home_wins
    GameTeam.percentage_home_wins
  end

  def percentage_visitor_wins
    GameTeam.percentage_visitor_wins
  end

  def percentage_ties
    GameTeam.percentage_ties
  end

  def highest_scoring_visitor
    GameTeam.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    GameTeam.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    GameTeam.lowest_scoring_home_team
  end

  def highest_scoring_home_team
    GameTeam.highest_scoring_home_team
  end

  def count_of_teams
    Offense.count_of_teams
  end

  def best_offense
    Offense.best_offense
  end

  def worst_offense
    Offense.worst_offense
  end

  # def best_defense
  #   Defense.best_defense
  # end

  # def worst_defense
  #   Defense.worst_defense
  # end
end
