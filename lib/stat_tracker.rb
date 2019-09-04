require 'CSV'
require './lib/team'
require './lib/game'
require './lib/game_team'
require 'pry'

class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    teams = []
    CSV.read(locations[:teams]).each_with_index do |line, index|
      unless index == 0
        teams << Team.new(line)
      end
    end

    games = []
    CSV.read(locations[:games]).each_with_index do |line, index|
      unless index == 0
        games << Game.new(line)
      end
    end

    game_teams = []
    CSV.read(locations[:game_teams]).each_with_index do |line, index|
      unless index == 0
        game_teams << GameTeam.new(line)
      end
    end

    StatTracker.new(teams, games, game_teams)
  end
end
