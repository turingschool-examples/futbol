require './lib/game.rb'
require './lib/league.rb'
require './lib/team.rb'
require './lib/season.rb'
require './spec/spec_helper'

class StatTracker
  attr_reader :games, :teams, :game_teams, :game, :league, :season, :team

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol

    @game = Game.new(games, teams, game_teams)
    @league = League.new(games, teams, game_teams)
    @season = Season.new(games, teams, game_teams)
    @team = Team.new(games, teams, game_teams)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

###########Game Stats###############
  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def percentage_ties
    @game.percentage_ties
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def average_goals_per_game
    @game.average_goals_per_game
  end

  def average_goals_by_season
    @game.average_goals_by_season
  end
###########League Stats##############

  def count_of_teams
    @league.count_of_teams
  end

  def best_offense
    @league.best_offense
  end

############Season Stats##############
  def winningest_coach(season)
    @season.winningest_coach(season)
  end

  def worst_coach(season)
    @season.worst_coach(season)
  end

###################Team Stats###############
  def team_info(id)
    @team.team_info(id)
  end

  def best_season(team_id)
    @team.best_season(team_id)
  end

  def worst_season(team_id)
    @team.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team.rival(team_id)
  end
end
