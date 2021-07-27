require 'CSV'
class StatTracker

  attr_reader :games, :teams, :game_teams

  def initialize(file_paths)
    @games = CSV.read(file_paths[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(file_paths[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(file_paths[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(file_paths)
    StatTracker.new(file_paths)
    require "pry"; binding.pry
  end

end
