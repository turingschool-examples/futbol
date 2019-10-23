require_relative './game'
require_relative './team'
require_relative './game_team'
require 'CSV'


class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(locations)

    games = []
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end

    teams = []
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end

    game_teams = []
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end


    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    highest = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest.away_goals + highest.home_goals
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest.away_goals + lowest.home_goals
  end

  def biggest_blowout
    biggest = @games.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end
    (biggest.away_goals - biggest.home_goals).abs
  end
end
