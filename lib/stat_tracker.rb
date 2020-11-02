require './lib/game_collection'
require './lib/team_collection'
require './lib/game_team_collection'

class StatTracker
  attr_reader :game_collection,
              :team_collection,
              :game_team_collection

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    load_collections(locations)
  end

  def load_collections(locations)
    @game_collection = GameCollection.new(locations[:games], self)
    @team_collection = TeamCollection.new(locations[:teams], self)
    @game_team_collection = GameTeamCollection.new(locations[:game_teams], self)
  end


# Game Stats

  def compare_hoa_to_result(hoa, result)
    @game_team_collection.compare_hoa_to_result(hoa, result)
  end

  def highest_total_score
    @game_collection.highest_total_score
  end

  def lowest_total_score
    @game_collection.lowest_total_score
  end

  def percentage_home_wins
    @game_team_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_team_collection.percentage_visitor_wins
  end

  def percentage_ties
    @game_team_collection.percentage_ties
  end

  def count_of_games_by_season
    @game_collection.count_of_games_by_season
  end

  def average_goals_per_game
    @game_collection.average_goals_per_game
  end


  def average_goals_by_season
    @game_collection.average_goals_by_season
  end

# Season Statistics

  def game_ids_per_season
    @game_collection.game_ids_per_season
  end

  def winningest_coach(season)
    @game_team_collection.winningest_coach(season)
  end

  def worst_coach(season)
    @game_team_collection.worst_coach(season)
  end

  def most_accurate_team(season)
    @game_team_collection.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_team_collection.least_accurate_team(season)
  end

  def most_tackles(season)
    @game_team_collection.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_team_collection.least_tackles(season)
  end

  # def find_team(team_id)
  #   @team_collection.find_team(team_id)
  # end


  def count_of_teams
    @team_collection.count_of_teams
  end

  def best_offense
    @game_team_collection.best_offense
  end

  def worst_offense
    @game_team_collection.worst_offense
  end

  def highest_scoring_visitor
    @game_team_collection.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_team_collection.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_team_collection.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_team_collection.lowest_scoring_home_team
  end

# League Statistics Helper Methods
  def find_team_name(team_id)
    @team_collection.find_team_name(team_id)
  end

  def total_goals_per_team_id_away
    @game_collection.total_goals_per_team_id_away
  end

  def total_games_per_team_id_away
    @game_collection.total_games_per_team_id_away
  end

  def total_goals_per_team_id_home
    @game_collection.total_goals_per_team_id_home
  end

  def total_games_per_team_id_home
    @game_collection.total_games_per_team_id_home
  end

# Team Statistics
  def team_info(team_id)
    @team_collection.team_info(team_id)
  end

  def best_season(team_id)
    @game_collection.best_season(team_id)
  end

  def worst_season(team_id)
    @game_collection.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_team_collection.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team_collection.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team_collection.fewest_goals_scored(team_id)
  end

  def favorite_oponent(team_id)
    find_team_name(@game_team_collection.lowest_win_percentage(team_id))
  end

  def rival(team_id)
    find_team_name(@game_team_collection.highest_win_percentage(team_id))
  end
end
