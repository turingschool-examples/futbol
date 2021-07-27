require 'rspec'
require './lib/stattracker'
require 'simplecov'

SimpleCov.start

RSpec.describe StatTracker do
  before(:all) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {games: @game_path, teams: @team_path, game_teams: @game_teams_path}
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  xit 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
  end
end
