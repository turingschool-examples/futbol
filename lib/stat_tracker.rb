require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_team_collection'
require 'CSV'


class StatTracker
  attr_reader  :game_collection, :team_collection

  def self.from_csv(locations)
    game_file = locations[:games]
    team_file = locations[:teams]
    game_teams_file = locations[:game_teams]

    game_collection = GameCollection.load_data(game_file)
    team_collection = TeamCollection.load_data(team_file)

    StatTracker.new(game_collection, team_collection, game_teams_file)
  end

  def initialize(game_collection, team_collection, game_teams_file)
    @game_collection = game_collection
    @team_collection = team_collection
    @game_teams_file = game_teams_file
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
end
