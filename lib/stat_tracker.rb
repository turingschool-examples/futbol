require 'csv'
require 'simplecov'
require_relative './game_stats'
require_relative './league_stats.rb'
require_relative './season_stats.rb'
require_relative './team_stats.rb'

SimpleCov.start

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_teams_path = locations[:game_teams]
    @teams_path = locations[:teams]
    @games_path = locations[:games]
  end

  def count_of_teams
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.count_of_teams
  end

  def best_offense
    league_stats = LeagueStats.new(@game_teams_path)
    team_id = league_stats.best_offense #<<<<< Need to refactor this, unless I get the exact answer
  end


end
