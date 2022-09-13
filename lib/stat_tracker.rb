require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(csv_hash)
    games_input = CSV.read(csv_hash[:games], headers: true, header_converters: :symbol).take(200)
    teams_input = CSV.read(csv_hash[:teams], headers: true, header_converters: :symbol).take(200)
    game_teams_input = CSV.read(csv_hash[:game_teams], headers: true, header_converters: :symbol).take(200)
    stats_tracker = StatTracker.new(games_input.map {|row| row}, teams_input.map {|row| row}, game_teams_input.map {|row| row})
  end
end