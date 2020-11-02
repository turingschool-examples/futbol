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

  def scores_by_game
    @game_collection.scores_by_game
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

  def total_games
    @game_collection.total_games
  end

  def average_goals_per_game
    @game_collection.average_goals_per_game
  end

  def sum_of_scores_by_season
    @game_collection.sum_of_scores_by_season
  end

  def season_id
    @game_collection.season_id
  end

  def average_goals_by_season
    @game_collection.average_goals_by_season
  end

# Season Statistics

  def game_ids_per_season
    @game_collection.game_ids_per_season
  end

  def games_in_season(season)
    @game_team_collection.games_in_season(season)
  end

  def games_per_coach(season)
    @game_team_collection.games_per_coach(season)
  end

  def count_coach_results(season)
    @game_team_collection.count_coach_results(season)
  end

  def coach_percentage(season)
    @game_team_collection.coach_percentage(season)
  end

  def winningest_coach(season)
    @game_team_collection.winningest_coach(season)
  end

  def worst_coach(season)
    @game_team_collection.worst_coach(season)
  end

  def team_scores(season, attribute)
    @game_team_collection.team_scores(season)
  end

  def team_ratios(season)
    @game_team_collection.team_ratios(season)
  end

  def most_accurate_team(season)
    @game_team_collection.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_team_collection.least_accurate_team(season)
  end

  def total_tackles(season)
    @game_team_collection.total_tackles(season)
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

# League Statistics Methods
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
end
