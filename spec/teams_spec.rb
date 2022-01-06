require './lib/teams'
require './lib/stat_tracker'
# require 'pry'

RSpec.describe Team do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    teams = Team.new("cosa")
    expect(teams).to be_instance_of(Team)
  end

  it 'can take a csv file from a stat tracker' do
    teams = Team.new(@stat_tracker.files[:teams])
    expect(teams.teams_file).to eq('./data/games.csv')
  end

  it 'can take a csv file from a stat tracker' do
    teams = Team.new(@stat_tracker.locations[:teams])
    teams.read_file
    expect(teams.teams_file).to eq('./data/games.csv')
  end
end
