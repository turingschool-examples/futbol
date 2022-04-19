require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'
require './lib/game_team'
require './lib/team'
require './lib/game'
require 'csv'

RSpec.describe StatTracker do

  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end
end
