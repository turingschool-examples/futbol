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
    teams = TeamsCollection.new(@stat_tracker.locations[:teams])
    expect(teams).to be_a(TeamsCgit ollection)
  end

  xit 'can take a csv file from a stat tracker' do

    teams = Team.new(@stat_tracker.locations[:teams])
    expect(teams.teams_file).to eq('./data/teams.csv')
  end


end
