require 'csv'
require './lib/game'
require './lib/game_team'
require './lib/team'
require './lib/league'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :league

  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @games = games_array_creator(locations[:games])
    @teams = teams_array_creator(locations[:teams])
    @game_teams = game_teams_array_creator(locations[:game_teams])
    @league = League.new(@games, @teams, @game_teams)
  end

  def games_array_creator(path)
    games_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def teams_array_creator(path)
    teams_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def game_teams_array_creator(path)
    game_teams_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end

#Statistics Methods
  def highest_total_score
    @league.total_goals_array.max
  end

  def lowest_total_score
    @league.total_goals_array.min
  end

  def average_goals_per_game
    (@league.total_goals_array.sum(0.0) / @league.total_goals_array.length).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @all_data_hash[:games].each do |row|
      games_by_season[row[:season]] += 1
    end
    games_by_season
  end
end
