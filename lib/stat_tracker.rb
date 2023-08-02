require 'csv'

class StatTracker
  attr_reader :games,
              :game_teams,
              :teams

  def initialize(games, game_teams, teams)
    @games = games
    @game_teams = game_teams
    @teams = teams
  end

  def self.from_csv(locations)
    games_contents = locations[:games]
    game_teams_contents = locations[:game_teams]
    teams_contents = locations[:teams]
    StatTracker.new(games_contents, game_teams_contents, teams_contents)
  end

  def highest_total_score

  end

  def lowest_total_score

  end

  def percentage_home_wins

  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def highest_scoring_home_team

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def most_tackles

  end

  def fewest_tackles
    
  end
end