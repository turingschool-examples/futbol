require 'csv'
require_relative './teams'
require_relative './game_teams'
require_relative './games'

class StatTracker
  attr_accessor :games, :teams, :game_teams

  def initialize()
    @games = []
    @teams = []
    @game_teams = []
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new()
    rows = CSV.read(locations[:teams], headers: true)
    rows.each do |row|
      team = Teams.new(row)
      stat_tracker.teams << team
    end

    rows = CSV.read(locations[:games], headers: true)
    rows.each do |row|
      games = Games.new(row)
      stat_tracker.games << games
    end

    rows = CSV.read(locations[:game_teams], headers: true)
    rows.each do |row|
      game_teams = GameTeams.new(row)
      stat_tracker.game_teams << game_teams
    end
    return stat_tracker
  end

  #Game Statistics Methods
  def highest_total_score
    game_score = @games.map {|game| game.away_goals + game.home_goals}
    game_score.max
  end

  def lowest_total_score
    game_score = @games.map {|game| game.away_goals + game.home_goals}
    game_score.min
  end
end
