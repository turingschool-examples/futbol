require 'csv'
require 'pry'

class StatTracker
  def initialize(games, teams, game_results)
    @games      = games
    @teams      = teams
    @game_results = game_results
  end

  def self.from_csv(locations)
    games = CSV.parse(File.read(locations[:games]), headers: true)
    teams = CSV.parse(File.read(locations[:teams]), headers: true)
    game_results = CSV.parse(File.read(locations[:game_teams]), headers: true)
    ted_lasso = StatTracker.new(games, teams, game_results)
    return ted_lasso
  end

end
