require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'

class StatTracker < GameManager

  attr_reader :games, :game_details, :teams

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    @game_teams_array = []
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end

    @games_array = []
    CSV.foreach(locations[:games], headers: true) do |row|
      @games_array << Game.new(row)
    end

    @teams_array = []
    CSV.foreach(locations[:teams], headers: true) do |row|
      @teams_array << Team.new(row)
    end

    @team_hash = {}
CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
  @team_hash[row[2]] = Team.new(row)
    end
  end
end
