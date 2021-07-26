require 'rspec'
require './lib/stattracker'
require 'simplecov'

SimpleCov.start

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {games: @game_path, teams: @team_path, game_teams: @game_teams_path}
  end 

  it 'exists with attributes' do
    st = StatTracker.new

    expect(st).to be_a(StatTracker)
  end

end
