require 'csv'
require_relative 'game_stats'
require_relative 'league_stats'

class StatTracker
  include GameStats
  include LeagueStats
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(hash_game_objs, hash_team_objs, hash_game_teams_objs)
    @games = hash_game_objs
    @teams = hash_team_objs
    @game_teams = hash_game_teams_objs
  end

      #passing in hash of csv paths for each csv file
  def StatTracker.from_csv(locations)

    games = {}
    teams = {}
    game_teams = Hash.new {|k,v| game_teams[k] = []}

    CSV.foreach(locations[:games], headers: true) do |row|
      game = Game.new(row.to_s)
      games[game.game_id] = game
    end

    CSV.foreach(locations[:teams], headers: true) do |row|
      team = Team.new(row.to_s)
      teams[team.team_id] = team
    end

    CSV.foreach(locations[:game_teams], headers: true) do |row|
      game_team =  GameTeams.new(row.to_s)
      game_teams[game_team.team_id] = [] << game_team
    end

    StatTracker.new(games, teams, game_teams)
  end

end
