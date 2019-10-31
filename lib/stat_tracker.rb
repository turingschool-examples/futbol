require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_team_collection'
require 'CSV'


class StatTracker
  attr_reader  :game_collection, :team_collection, :game_team_collection

  def self.from_csv(locations)
    game_file = locations[:games]
    team_file = locations[:teams]
    game_team_file = locations[:game_teams]

    game_collection = GameCollection.load_data(game_file)
    team_collection = TeamCollection.load_data(team_file)
    game_team_collection = GameTeamCollection.load_data(game_team_file)

    StatTracker.new(game_collection, team_collection, game_team_collection)
  end

  def initialize(game_collection, team_collection, game_team_collection)
    @game_collection = game_collection
    @team_collection = team_collection
    @game_team_collection = game_team_collection
  end

  def highest_total_score
    @game_collection.highest_score
  end

  def lowest_total_score
    @game_collection.lowest_score
  end

  def biggest_blowout
    @game_collection.blowout
  end

  def percentage_home_wins
    @game_collection.percent_home_wins
  end

  def percentage_visitor_wins
    @game_collection.percent_visitor_wins
  end

  def percentage_ties
    @game_collection.percent_ties
  end

  def count_of_games_by_season
    @game_collection.count_of_games_by_season
  end

  def average_goals_per_game
    @game_collection.avg_goals_per_game
  end

  def average_goals_by_season
    @game_collection.avg_goals_in_season
  end

  def count_of_teams
    @team_collection.team_count
  end

  def best_offense
    @team_collection.team_name(@game_team_collection.most_goals)
  end

  def highest_scoring_visitor
    @team_collection.team_name(@game_team_collection.most_visitor_goals)
  end

  def highest_scoring_home_team
    @team_collection.team_name(@game_team_collection.most_home_goals)
  end

  def winningest_team
    @team_collection.team_name(@game_team_collection.team_highest_win_percent)
  end
  
  def worst_offense
    @team_collection.team_name(@game_team_collection.fewest_goals)
  end

  # def best_defense
  #   @team_collection.team_name(@game_collection.allowed(@game_team_collection.fewest_allowed_goals))
  # end

  def best_fans
    @team_collection.team_name(@game_team_collection.team_with_best_fans)
  end

  def worst_fans
    @team_collection.team_name_array(@game_team_collection.team_with_worst_fans)
  end
end
