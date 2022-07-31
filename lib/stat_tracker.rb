require 'csv'
require 'forwardable'
require_relative 'game'
require_relative 'league_statistics'
require_relative 'season_statistics'
require_relative 'team_statistics'

class StatTracker 
  extend Forwardable
  attr_reader :data, 
              :game,
              :league_statistics, 
              :team_statistics,
              :season_statistics

  def_delegators :@game, :percentage_home_wins, :percentage_visitor_wins, :lowest_total_score, :highest_total_score, :percentage_ties,
                 :count_of_games_by_season, :average_goals_per_game, :average_goals_by_season
  def_delegators :@league_statistics, :count_of_teams, :best_offense, :worst_offense, :highest_scoring_visitor, :highest_scoring_home_team, 
                 :lowest_scoring_visitor, :lowest_scoring_home_team
  def_delegators :@team_statistics, :team_info, :best_season, :worst_season, :average_win_percentage, :most_goals_scored, :fewest_goals_scored,
                 :favorite_opponent, :rival
  def_delegators :@season_statistics, :winningest_coach, :worst_coach, :most_accurate_team, :least_accurate_team, :most_tackles, :fewest_tackles

  def initialize(locations)
    game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    games = CSV.read locations[:games], headers: true, header_converters: :symbol
    teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @data = {game_teams: game_teams, games: games, teams: teams}
    @game = Game.new(@data)
    @league_statistics = LeagueStatistics.new(@data)
    @team_statistics = TeamStatistics.new(@data)
    @season_statistics = SeasonStatistics.new(@data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end