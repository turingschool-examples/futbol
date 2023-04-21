require "csv"
require_relative "./game"
require_relative "./game_teams"
require_relative "./teams"

class StatHelper
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(files)
    @games = (CSV.open files[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = (CSV.open files[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
    @teams = (CSV.open files[:teams], headers: true, header_converters: :symbol).map { |row| Teams.new(row) }
  end
end
