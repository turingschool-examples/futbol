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
    game_path = './data/games_test.csv'
    team_path = './data/teams_test.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    expect(StatTracker.from_csv(locations)).to be_a (Hash)

  end
end
