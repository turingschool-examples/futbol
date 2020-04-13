require './lib/stat_tracker'
require 'pry';

class Statistics
  def initialize(stats)
    @stat_tracker = stats
    @csv_games = CSV.read(stat_tracker.games, headers: true, header_converters: :symbol)
    @csv_teams = CSV.read(stat_tracker.teams, headers: true, header_converters: :symbol)
    @csv_game_teams = CSV.read(stat_tracker.game_teams, headers: true, header_converters: :symbol)
  end
