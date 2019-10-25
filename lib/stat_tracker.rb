require_relative 'game_team'
require_relative 'team'
require_relative 'game'
require_relative 'game_module'
require_relative 'league_module'
require_relative 'season_module'
require_relative 'team_module'
<<<<<<< HEAD
=======

>>>>>>> a03afb82e303b60969be1dbf01c0c1cea7cdfc2c

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
