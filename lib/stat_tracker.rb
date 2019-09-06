require 'csv'
require_relative 'game_stats'
require_relative 'league_stats'

class StatTracker
  include GameStats
  include LeagueStats
  attr_reader :game_objs,
              :team_objs,
              :game_teams_objs

  def initialize(array_game_objs, array_team_objs, array_game_teams_objs)
    @game_objs = array_game_objs
    @team_objs = array_team_objs
    @game_teams_objs = array_game_teams_objs
  end

      #passing in hash of csv paths for each csv file
  def StatTracker.from_csv(locations)

    game_objs = []
    team_objs = []
    game_teams_objs = []

    CSV.foreach(locations[:games], headers: true) do |row|
      game_objs << Game.new(row.to_s)
    end

    CSV.foreach(locations[:teams], headers: true) do |row|
      team_objs << Team.new(row.to_s)
    end

    CSV.foreach(locations[:game_teams], headers: true) do |row|
      game_teams_objs << GameTeams.new(row.to_s)
    end

    StatTracker.new(game_objs, team_objs, game_teams_objs)
  end

end
