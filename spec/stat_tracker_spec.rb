require './lib/stat_tracker'


RSpec.describe "Stat Tracker" do
  before(:each) do
      @game_path       = './data/games_sample.csv'
      @game_teams_path = './data/game_teams_sample.csv'
      @team_path       = './data/teams.csv'

      @locations = {
                    games: @game_path,
                    teams: @team_path,
                    game_teams: @game_teams_path
                  }
      @stat_tracker = StatTracker.from_csv(@locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a StatTracker
  end

  it "has attributes" do
    expect(@stat_tracker.games.count).to eq(25)
    expect(@stat_tracker.teams.count).to eq(33)
    expect(@stat_tracker.game_teams.count).to eq(31)
  end

  it 'can create an array of hashes from a CSV' do
    expect(@stat_tracker.to_array(@team_path)).to be_an(Array)
    expect(@stat_tracker.to_array(@team_path).first).to be_a(Hash)
    expect(@stat_tracker.to_array(@team_path).count).to eq(32)
    expect(@stat_tracker.to_array(@team_path).first.count).to eq(6)
    expect(@stat_tracker.to_array(@team_path).sample.count).to eq(6)
  end
end
