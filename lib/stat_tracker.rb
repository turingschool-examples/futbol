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
    @game = Game.new(locations)

  end



  def self.from_csv(locations)
    StatTracker.new(locations)
  end

###########Game Stats###############
  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score

  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end
###########League Stats##############

  def count_of_teams
  end

  def best_offense
  end

############Season Stats##############
  def winningest_coach(season)
  end

  def worst_coach(season)
  end

###################Team Stats###############
  def team_info(id)
  end

  def best_season(team_id)
  end

end
