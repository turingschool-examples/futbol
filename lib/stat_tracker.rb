require './lib/game.rb'
require './lib/league.rb'
require './lib/team.rb'
require './lib/season.rb'
require './spec/spec_helper'
class StatTracker
  attr_reader :games, :game, :teams, :game_teams, :home_goals, :away_goals, :season

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @home_goals = []
    @away_goals = []
    @season = []
    #@game = Game.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

###########Game Stats###############
  def highest_total_score
    Game.new.highest_total_score(@games)
  end

  def lowest_total_score
    Game.new.lowest_total_score(@games)
  end

  def percentage_home_wins
    Game.new.percentage_home_wins(@game_teams)
  end

  def percentage_visitor_wins
    Game.new.percentage_visitor_wins(@game_teams)
  end

  def percentage_ties
    Game.new.percentage_ties(@games)
  end

  def count_of_games_by_season
    Game.new.count_of_games_by_season(@games)
  end

  def average_goals_per_game
    Game.new.average_goals_per_game(@games)
  end

  def average_goals_by_season
    Game.new.average_goals_by_season(@games)
  end
###########League Stats##############

  def count_of_teams
    League.new.count_of_teams(@teams)
  end

  def best_offense
    League.new.best_offense(@teams)
  end

############Season Stats##############
  def winningest_coach(season)
    Season.new.winningest_coach(season, @game_teams, @games)
  end

  def worst_coach(season)
    Season.new.worst_coach(season, @game_teams, @games)
  end

###################Team Stats###############
  def team_info(id)
    Team.new.team_info(id, @teams)
  end

  def best_season(team_id)
    Team.new.best_season(team_id, @games, @game_teams)
  end
end
