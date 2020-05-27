
require "csv"
require "./lib/game"
require "./lib/team"
require "./lib/game_team"

class StatTracker
  @@games = []
  @@teams = []
  @@game_teams = []
  def self.from_csv(location)
    games_data = CSV.read(location[:games], headers: true, header_converters: :symbol)
    @@games = games_data.map do |row|
      Game.new(row)
     end

    teams_data = CSV.read(location[:teams], headers: true, header_converters: :symbol)
    @@teams = teams_data.map do |row|
      Team.new(row)
    end

    game_teams_data = CSV.read(location[:game_teams], headers: true, header_converters: :symbol)
    @@game_teams = game_teams_data.map do |row|
      GameTeam.new(row)
    end

    StatTracker.new
  end

  def games
    @@games
  end

  def teams
    @@teams
  end

  def game_teams
    @@game_teams
  end
end
