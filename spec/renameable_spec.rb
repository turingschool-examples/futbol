require './lib/stat_tracker'
require './lib/season_statistics'
require 'simplecov'
require 'CSV'

SimpleCov.start
RSpec.describe Renameable do
  before :each do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @renameable = Renameable.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end

  xit 'exists' do
    expect(renameable).to be_a(Renameable)
  end
end
