require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize
  end

  def self.from_csv(csv_hash)
    # @games_input = CSV.open csv_hash[:games], headers: true, header_converters: :symbol
    @games_input = CSV.foreach(csv_hash[:games], headers: true, header_converters: :symbol).take(200)
    # @teams_input = CSV.open csv_hash[:teams], headers: true, header_converters: :symbol
    @teams_input = CSV.foreach(csv_hash[:teams], headers: true, header_converters: :symbol).take(200)
    # @game_teams_input = CSV.open csv_hash[:game_teams], headers: true, header_converters: :symbol
    @game_teams_input = CSV.foreach(csv_hash[:game_teams], headers: true, header_converters: :symbol).take(200)
    @stats = [@games_input.map {|row| row}, @teams_input.map {|row| row}, @game_teams_input.map {|row| row}]
  end
end