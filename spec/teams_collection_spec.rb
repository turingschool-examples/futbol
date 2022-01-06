require './lib/teams_collection'
require './lib/stat_tracker'
require 'pry'

RSpec.describe TeamsCollection do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path }


      @stat_tracker = StatTracker.from_csv(locations)
  end
  it 'exists' do
    games = TeamsCollection.new("stuff")
    expect(teams).to be_a(Teams)
  end

  xit 'can take a csv file from a stat tracker' do

    games = Teams.new(@stat_tracker.locations[:teams])
    expect(games.teams_file).to eq('./data/teams.csv')
  end

  xit 'can take a csv file from a stat tracker' do

    games = Teams.new(@stat_tracker.locations[:teams])
    games.readfile
    expect(games.teams_file).to eq('./data/teams.csv')
  end
end
