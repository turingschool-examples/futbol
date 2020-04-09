require './lib/stat_tracker'
require 'pry';

class Statistics
  def initialize(stats)
    @stat_tracker = stats
    @csv_games = CSV.read(stat_tracker.games, headers: true, header_converters: :symbol)
    @csv_teams = CSV.read(stat_tracker.teams, headers: true, header_converters: :symbol)
    @csv_game_teams = CSV.read(stat_tracker.game_teams, headers: true, header_converters: :symbol)
  end

  def create_games
  @csv_games.map { |row| Game.new(row) }
  end

  def create_game_teams
    @csv_game_teams.map { |row| GameTeam.new(row) }
  end

  def create_teams
    @csv_teams.map { |row| Team.new(row) }
  end
end
