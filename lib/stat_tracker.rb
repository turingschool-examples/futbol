#./lib/stat_tracker.rb
require_relative 'game'
require_relative 'league'
require_relative 'season'

class StatTracker
  def initialize
  end

  #We may need to initialize objects from the game, season, and league classes here
  # ie game_stats = Game.new(insert arguments here)
  # league_stats = League.new(arguments)
  # season_stats = Season.new(arguments)

  def highest_total_score
    game_stats.highest_total_score
  end

  def lowest_total_score
    game_stats.lowest_total_score
  end

  def percentage_home_wins
    game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    game_stats.percentage_visitor_wins
  end

  def percentage_ties
    game_stats.percentage_ties
  end

  def count_of_games_by_season
    game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    game_stats.average_goals_per_game
  end

  def average_goals_by_season
    game_stats.average_goals_by_season
  end
  
  def count_of_teams
    league_stats.count_of_teams
  end

  def best_offense
    league_stats.best_offense
  end

  def worst_offense
    league_stats.worst_offense
  end

  def highest_scoring_visitor
    league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    league_stats.lowest_scoring_visitor
  end

  def winningest_coach
    season_stats.winningest_coach
  end

  def worst_coach
    season_stats.worst_coach
  end

  def most_accurate_team
    season_stats.most_accurate_team
  end

  def least_accurate_team
    season_stats.least_accurate_team
  end

  def most_tackles
    season_stats.most_tackles
  end

  def fewest_tackles
    season_stats.fewest_tackles
  end

end