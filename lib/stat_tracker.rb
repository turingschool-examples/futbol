require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_results
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

  def highest_total_score
    @game_results.map do |results|
      if  results.find
  end

end
