require './lib/statistics'
require './lib/season_tracker'
require './lib/game_team'
require './lib/game'
require './lib/game_team_tracker'

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
      games: './data/games_stub_2.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.best_worst_coach("20122013", 'best')).to eq("Claude Julien")
  end

  it 'worst coach' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub_2.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.best_worst_coach("20122013", 'worst')).to eq("John Tortorella")
  end

  it 'most_accurate_team' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub_2.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.accurate_team("20122013", 'most')).to eq("FC Dallas")
  end

  it 'least_accurate_team' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub_2.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.accurate_team("20122013", 'least')).to eq("Sporting Kansas City")
  end

  it 'most_tackles' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub_2.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.most_tackles("20122013")).to eq("FC Dallas")
  end

  it 'fewest_tackles' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub_2.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    season_tracker = SeasonTracker.new(locations)
    expect(season_tracker.fewest_tackles("20122013")).to eq("New England Revolution")
  end
end
