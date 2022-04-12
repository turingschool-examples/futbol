require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/team'


describe StatTracker do
  before :each do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
	  expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

	it "has a team" do
		@team1 = Team.new('1', '23', 'Atlanta United', 'ATL', 'Mercedes-Benz Stadium', 'link')
		expect(@stat_tracker.team[0]).to eq '1'
	end
end
