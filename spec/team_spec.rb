require 'simplecov'
SimpleCov.start
require './lib/team_tracker'

RSpec.describe do TeamTracker
  it 'exists' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker).to be_a(TeamTracker)
  end

  it 'tests team info' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.team_info("1")).to eq(
      {:team_id=>"1",
      :franchiseid=>"23",
      :teamname=>"Atlanta United",
      :abbreviation=>"ATL",
      :stadium=>"Mercedes-Benz Stadium",
      :link=>"/api/v1/teams/1"}
    )
  end

  it 'tests best season' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.best_season("6")).to eq("20132014")
  end

  it 'tests worst season' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.worst_season("6")).to eq("20142015")
  end

  it 'tests average_win_percentage' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.average_win_percentage("6")).to eq(0.49)
  end

  it 'tests most goals scored' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.most_goals_scored("18")).to eq(7)
  end

  it 'tests fewest_goals_scored' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.fewest_goals_scored("18")).to eq(0)
  end

  it 'tests favorite opponent' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.favorite_opponent("18")).to eq("DC United")
  end

  it 'rival' do
    game_path = './data/game_teams.csv'
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: game_path}
    team_tracker = TeamTracker.new(locations)
    expect(team_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end
end
