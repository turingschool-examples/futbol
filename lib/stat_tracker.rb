require 'csv'

class StatTracker

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true)
    games = CSV.parse(File.read(locations[:games]), headers: true)
    teams = CSV.parse(File.read(locations[:teams]), headers: true)
    self.new(game_teams, games, teams)
  end

end
