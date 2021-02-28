require 'CSV'
require 'pry'
require_relative './game'
require_relative './csv_parser'

class GameTeamManager
  include CsvParser

  def initialize(file)
    @all_game_teams = load_it_up(file, GameTeam)
    # CSV.read(locations, headers: true, header_converters: :symbol) do |row|
    #
    #   @all_game_teams << GameTeams.new(row, self)
    # end
    # /Users/zacherybergman/futbol/lib/stat_tracker.rb
    # /Users/zacherybergman/futbol_spec_harness
  end
end
