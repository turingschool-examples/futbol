require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/game_team'
require 'csv'
require './lib/game'
require './lib/game_team_tracker'

RSpec.describe do GameTeamTracker
  it 'exists' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    game_tracker = GameTeamTracker.new(locations)
    expect(game_tracker).to be_a(GameTeamTracker)
  end

  it 'can count teams' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    game_tracker = GameTeamTracker.new(locations)
    expect(game_tracker.count_of_teams).to eq(5)
  end

  it 'can tell best offense' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    game_tracker = GameTeamTracker.new(locations)
    #expect(game_tracker.best_offense).to include("6")
    expect(game_tracker.best_offense).to eq("FC Dallas")
  end

  it 'can tell worst offense' do
    game_path = './data/game_teams_stub.csv'
    team_path = './data/teams.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path
    }
    # binding.pry
    game_tracker = GameTeamTracker.new(locations)
    #expect(game_tracker.worst_offense).to include("5")
    expect(game_tracker.worst_offense).to eq("Sporting Kansas City")
  end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end

end
