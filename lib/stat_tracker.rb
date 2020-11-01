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
