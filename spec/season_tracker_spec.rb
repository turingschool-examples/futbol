require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/game_team'
require 'csv'
require './lib/game'
require './lib/game_team_tracker'
require './lib/season_tracker'

RSpec.describe do SeasonTracker
  it 'exists' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker).to be_a(SeasonTracker)
  end



  it 'winningest coach' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.winningest_coach).to be_a(SeasonTracker)
  end
end
