require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/raw_stats'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
  # Variable names for methods to be implimented
    stats = RawStats.new(data)
    @games = stats.games
    @teams = stats.teams
    @game_teams = stats.game_teams
    #require 'pry'; binding.pry
  # How do we want to get these objects to have statistics characteristics (for connecting raw stats)?
  # class GameStats < RawStats
  end

  def count_of_games_by_season
    result = {}
    @games.each do |game|
      if result[game.season].nil?
        result[game.season] = 1
      else
        result[game.season] += 1
      end
    end
    result
  end

  # Implement the remaining methods for statistics calculations
  # ...

end
