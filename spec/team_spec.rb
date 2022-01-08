require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/game_team'
require 'csv'
require './lib/game'
require './lib/game_team_tracker'
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


end
