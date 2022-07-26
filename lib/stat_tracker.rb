require 'CSV'
require './lib/game'
# require './lib/teams'
# require './lib/game_teams'

class StatTracker
  attr_reader :games

  def initialize(locations)
    @games = all_games(locations[:games])
    # @teams = Team.new(locations[:teams])
    # @game_teams = GameTeams.new(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def all_games(games_path)
    @all_games ||= []
    CSV.foreach(games_path, headers: true, header_converters: :symbol) do |data|
      @all_games << Game.new(data)
    end

    @all_games
  end
end
