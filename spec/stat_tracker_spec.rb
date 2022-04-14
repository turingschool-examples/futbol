require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/team'
require './lib/game_team'
require './lib/game'
require 'pry'

describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/dummy_teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

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

  it 'has game' do
    expect(@stat_tracker.games[0]).to be_a(Game)
  end

	it "has a team" do
		expect(@stat_tracker.teams[0]).to be_a(Team)
	end

  it 'has game_teams' do
    expect(@stat_tracker.game_teams[0]).to be_a(GameTeam)
  end

	it "it can calculate the highest total score of games" do
		expect(@stat_tracker.highest_total_score).to eq 5
	end

	it "can calculate the lowest total score of games" do
		expect(@stat_tracker.lowest_total_score).to eq 3
	end


	it "can return the percentage of games that a visitor has won" do
		expect(@stat_tracker.percentage_visitor_wins).to eq 40.0
	end

	it "can calculate a percentage of home wins" do
		expect(@stat_tracker.percentage_home_wins).to eq 60.0
	end


end
