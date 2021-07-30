require './lib/season_manager'
require './lib/stat_tracker'
require './lib/game_manager'

RSpec.describe SeasonManager do
  before(:each) do
    @game_path = './data/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/fixture_game_teams.csv'

    @file_paths = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.new(@file_paths)
  end

  it "is a thing" do
    expect(@stat_tracker.season_manager.seasons_hash).to eq(5)
  end
end
