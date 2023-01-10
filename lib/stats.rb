# require './lib/games'
# require './lib/game_teams'
# require './lib/team'
require './spec/spec_helper'

class Stats
  attr_reader :games,
              :game_teams,
              :teams

  def initialize(file_paths)
    @games = Game.create_games(file_paths[:games])
		@game_teams = GameTeams.create_game_teams(file_paths[:game_teams])
    @teams = Team.create_teams(file_paths[:teams])
  end
end