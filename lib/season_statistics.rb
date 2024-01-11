require 'csv'
require './lib/game_team'
require './lib/game'

class SeasonStatistics
  attr_reader :games,
              :game_teams

  def initialize(games, game_teams)
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(games_filepath, game_teams_filepath)
    game_teams = []

    CSV.foreach(game_teams_filepath, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end

    games = []

    CSV.foreach(games_filepath, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end

    new(games, game_teams)
  end
end
