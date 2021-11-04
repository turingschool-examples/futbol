require 'csv'
require './lib/game_team'
require './lib/team'
require './lib/game'

class StatTracker

  attr_accessor :location

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(location)
    @location = location
    @games = {}
    @teams = {}
    @game_teams = {}
  end

  def self.from_csv(locations)
    locations.map do |location|
      StatTracker.new(location)
    end
  end

  def read_game_stats(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      game = Game.new(row)
      @games[game.game_id] = game
    end
  end

  def read_team_stats(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      team = Team.new(row)
      @teams[team.team_id] = team
    end
  end

  def read_game_teams_stats(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      @game_teams[game_team.game_id] = game_team
    end
  end

  # League Statistics
  def count_of_teams
    @teams.length
  end
end
