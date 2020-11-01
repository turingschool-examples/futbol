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

# Season Stats
  def game_ids_per_season
    @game_collection.game_ids_per_season
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

# TEAM STATS
  def team_info(team_id)
    @team_collection.team_info(team_id)
  end

  def best_season(team_id)
    @game_collection.best_season(team_id)
  end

  def worst_season(team_id)
    @game_collection.worst_season(team_id)
  end
end
