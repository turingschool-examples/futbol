require './lib/stat_tracker'
require 'simplecov'
require 'csv'
# SimpleCov.start

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams_test.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end

  it 'exists' do
    # locations = {
    #   games: game_path,
    #   teams: team_path,
    #   game_teams: game_teams_path
    # }

    stat_tracker = StatTracker.from_csv(@locations)

    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end
end
