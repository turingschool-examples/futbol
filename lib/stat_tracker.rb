require './lib/game_team'
require './lib/team'
require './lib/game'
require './lib/game_module'
require './lib/league_module'
require './lib/season_module'
require './lib/team_module'
require 'pry'

class StatTracker
  include GameModule
  include LeagueModule
  include TeamModule
  include SeasonModule
  attr_reader :games, :teams, :game_teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeam.create(locations[:game_teams])
    games = Game.create(locations[:games])
    teams =  Team.create(locations[:teams])
    self.new(game_teams, games, teams)
  end


end
