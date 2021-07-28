require_relative 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do

  before(:each) do
    @game_path = './data/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/fixture_game_teams.csv'

    @file_paths = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@file_paths)
  end

  it 'total number of teams in the data' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end
end
