require 'csv'
class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games      = games#games-hash value
    @teams      = teams #same as above
    @game_teams = game_teams #same as above
  end


  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers: true)
    teams = CSV.read(locations[:teams], headers: true)
    game_teams = CSV.read(locations[:game_teams], headers: true)
    self.new(games, teams, game_teams)
  end

end