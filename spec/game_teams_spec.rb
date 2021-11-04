require 'spec_helper'
require './lib/game_team'
require './lib/game'
require './lib/team'
require './lib/stat_tracker'

RSpec.describe do

  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @filenames = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @new_stat_tracker = StatTracker.from_csv(@filenames)
  end

end
