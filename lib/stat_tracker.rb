require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize
    @games = nil
    @teams = nil
    @game_teams = nil
  end

  def self.from_csv(csv_hash)
    @games = CSV.open csv_hash[:games], headers: true, header_converters: :symbol
    @teams = CSV.open csv_hash[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.open csv_hash[:game_teams], headers: true, header_converters: :symbol
  end
end

# csv_preview_data = CSV.foreach(csv_path, headers: false).take(100)