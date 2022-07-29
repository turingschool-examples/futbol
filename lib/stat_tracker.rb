require 'csv'
require_relative './team'
require_relative './game'
require_relative './season'
require_relative './game_stats'
require_relative './league_stats'

class StatTracker
  include GameStats
  include LeagueStats

  attr_reader :games,
              :teams,
              :seasons

  def initialize(games, teams, game_teams)
    @teams = Team.generate_teams(teams) #array of team objects
    @games = Game.generate_games(games, game_teams, @teams)#an array of all game stats with hashes for home teams and away teams
    @seasons = Season.generate_seasons(@games) #a hash of season_id and keys and season objects as values
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games], converters: :all)
    teams = CSV.table(locations[:teams], converters: :all)
    game_teams = CSV.table(locations[:game_teams], converters: :all)
    StatTracker.new(games, teams, game_teams)
  end


  def most_accurate_team(season) @seasons[season.to_i].most_accurate_team end
  def least_accurate_team(season) @seasons[season.to_i].least_accurate_team end

  def most_tackles(season) @seasons[season.to_i].most_tackles end
  def fewest_tackles(season) @seasons[season.to_i].fewest_tackles end

end
