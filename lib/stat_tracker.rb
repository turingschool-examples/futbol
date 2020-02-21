require 'csv'
require './lib/game_teams_collection'
require './lib/game_collection'
require './lib/team_collection'

class StatTracker
  attr_reader :game_collection, :team_collection, :gtc
  def initialize(raw_data)
    @game_data = raw_data[:game_data]
    @team_data = raw_data[:team_data]
    @game_teams_data = raw_data[:game_teams_data]
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
  end

  def self.from_csv(locations)
    raw_data = {}
    raw_data[:game_data] = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    raw_data[:team_data] = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    raw_data[:game_teams_data] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    StatTracker.new(raw_data)
  end

  def load_data
    load_game_data
    load_team_data
    load_game_team_data
  end

  def load_game_team_data
    @gtc = GameTeamsCollection.new(@game_teams_data)
  end

  def load_game_data
    @game_collection = GameCollection.new(@game_data)
  end

  def load_team_data
    @team_collection = TeamCollection.new(@team_data)
  end

end
