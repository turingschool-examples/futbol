require './lib/stat_tracker'
require 'simplecov'
require 'csv'
# SimpleCov.start

RSpec.describe StatTracker do

  it 'exists' do
    # locations = {
    #   games: game_path,
    #   teams: team_path,
    #   game_teams: game_teams_path
    # }

    stat_tracker = StatTracker.new

    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end

  it '#game_data' do
    stat_tracker = StatTracker.new
    expect(stat_tracker.game_data('./data/games_test.csv')).to be(Array)
  end
end
