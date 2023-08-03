require 'csv'
require_relative 'team'
require_relative 'game'
require_relative "game_team"

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(files)
    @games = (CSV.foreach files[:games], headers: true, header_converters: :symbol).map do |row|
      Game.new(row)
    end
    @teams = (CSV.foreach files[:teams], headers: true, header_converters: :symbol).map do |row|
      Team.new(row)
    end
    @game_teams = (CSV.foreach files[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeam.new(row)
    end
  end

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def total_games
    total = 0.0
    @games.count do |game|
      total += 1
    end
    total
  end

  # def percentage_home_wins

  # end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end