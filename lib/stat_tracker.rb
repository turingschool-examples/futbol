require 'csv'
require_relative './game'
require_relative './team'
require_relative './game_team'


class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games], :headers=> true) do |row|
      games.push(Game.new(row))
    end

    teams = []
    CSV.foreach(locations[:teams], :headers=> true) do |row|
      teams.push(Team.new(row))
    end

    game_teams = []
    CSV.foreach(locations[:game_teams], :headers=> true) do |row|
      game_teams.push(GameTeam.new(row))
    end

    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    sum = 0
    @games.each do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum > sum
    end
    sum
  end
end
