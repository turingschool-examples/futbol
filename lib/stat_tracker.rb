require 'csv'
require_relative 'team'
require_relative 'game_teams'
require_relative 'league'
require_relative 'game'
require_relative 'season'
require_relative 'game_stat'

class StatTracker
  attr_reader :game_data, :team_data, :game_teams_data, :game, :league, :season, :game_stats

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    @games = @game_data.map { |game| Game.new(game) }
    @team_data = @team_data.map { |team| Team.new(team) }
    @game_teams_data = @game_teams_data.map { |game_teams| Game_teams.new(game_teams) }

    @game_stats = GameStats.new(@games)
  end
end