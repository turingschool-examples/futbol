require 'CSV'
require './lib/games'
require './lib/teams'
class StatTracker
  attr_reader :games,
              :teams

  def initialize(games, teams)
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)

    games = Hash.new
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      games[row[:game_id]] = Games.new(row)
    end

    teams = Hash.new
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      teams[row[:team_id]] = Teams.new(row)
    end
    require "pry"; binding.pry
    StatTracker.new(games, teams)
  end
end
