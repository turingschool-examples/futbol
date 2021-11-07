require 'csv'
require 'pry'
require_relative './futbol_data'
require_relative './game_team'
require_relative './game'
require_relative './team'
require_relative './season_methods'
require_relative './teams_methods'
require_relative './league_methods'
require_relative './league'

class StatTracker
  include SeasonMethods
  include Teams_Methods

  attr_reader :games, :teams, :game_teams

  def initialize(filenames)
    @league = League.new(filenames)
  end

  def self.from_csv(filenames)
    stat_tracker = StatTracker.new(filenames)
    stat_tracker
  end

  def count_of_teams
    @league.count_of_teams
  end

  def calc_avg_goals_alltime(team_id, location)
    @league.calc_avg_goals_alltime(team_id, location)
  end

  def best_offense
    @league.best_offense
  end

  def worst_offense
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  # team with the highest average score per game, all-time, at home
  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  # team with lowest average score per game, all-time, when playing away
  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  # team with the lowest average score per game, all-time, at home
  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end

end

StatTracker.from_csv({ games: './data/games.csv',
                       teams: './data/teams.csv',
                       game_teams: './data/game_teams.csv' })
