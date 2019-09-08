require 'csv'
require_relative 'game_stats'
require_relative 'league_stats'
require_relative 'generate_data'

class StatTracker
  include GameStats
  include LeagueStats
  include GenerateData
  attr_reader :games,
              :teams,
              :game_teams,
              #:league_stats

  def initialize(hash_game_objs, hash_team_objs, hash_game_teams_objs)
    @games = hash_game_objs
    @teams = hash_team_objs
    @game_teams = hash_game_teams_objs
    @league_stats = LeagueStats.new(@games)
  end

#  def count_of_teams
  #  league_stats.count_of_teams
#  end

  def StatTracker.from_csv(locations)

    games = {}
    teams = {}
    game_teams = {}

    CSV.foreach(locations[:games], headers: true) do |row|
      game = Game.new(row.to_s.chomp)
      games[game.game_id] = game
    end

    CSV.foreach(locations[:teams], headers: true) do |row|
      team = Team.new(row.to_s.chomp)
      teams[team.team_id] = team
    end


    CSV.foreach(locations[:game_teams], headers: true) do |row|
    game_team =  GameTeams.new(row.to_s.chomp)
      if game_teams.has_key?(game_team.team_id)
        game_teams[game_team.team_id] << game_team
      else
        game_teams[game_team.team_id] = [game_team]
      end
    end

    StatTracker.new(games, teams, game_teams)
  end


end
