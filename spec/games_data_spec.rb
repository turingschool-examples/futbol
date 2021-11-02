require './lib/stat_tracker'
require './lib/games_data'
require 'simplecov'
require 'csv'

RSpec.describe GamesData do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams_test.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'is exists' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj).to be_instance_of(GamesData)
  end

  it 'can store and access teams data' do
    game_obj = GamesData.new(@stat_tracker)

    expect(game_obj.game_data).to eq(@stat_tracker.games)
  end
end
