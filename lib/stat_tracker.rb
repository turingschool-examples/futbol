require_relative './games_collection'
require_relative './teams_collection'
require_relative './game_teams_collection'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def initialize(games_collection, teams_collection, game_teams_collection)
    @games_collection = games_collection
    @teams_collection = teams_collection
    @game_teams_collection = game_teams_collection
  end

  def self.from_csv(locations)
    games_collection = GamesCollection.new(locations[:games])
    teams_collection = TeamsCollection.new(locations[:teams])
    game_teams_collection = GameTeamsCollection.new(locations[:game_teams])

    StatTracker.new(games_collection, teams_collection, game_teams_collection)
  end

  def highest_total_score
    highest = @games_collection.games.max_by do |game|
      game.total_score
    end
    highest.total_score
  end

  def lowest_total_score
    lowest = @games_collection.games.min_by do |game|
      game.total_score
    end
    lowest.total_score
  end

  def percentage_home_wins
    (@games_collection.home_wins.to_f / @games_collection.games.length).round(2)
  end

  def percentage_visitor_wins
    (@games_collection.visitor_wins.to_f / @games_collection.games.length).round(2)
  end

  def percentage_ties
    (@games_collection.ties.to_f / @games_collection.games.length).round(2)
  end

  def count_of_games_by_season
    @games_collection.count_of_games_by_season
  end

  def average_goals_per_game
    @games_collection.average_goals_per_game
  end

  def average_goals_by_season
    @games_collection.average_goals_by_season
  end

  def count_of_teams
    @teams_collection.count_of_teams
  end

  def best_offense
    @game_teams_collection.goals_by_team
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

  def team_info(team_id)
    @teams_collection.team_info(team_id)
  end

  def best_season
  end

  def worst_season
  end

  def average_win_percentage
  end

  def most_goals_scored
  end

  def fewest_goals_scored
  end

  def favorite_opponent
  end

  def rival
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
