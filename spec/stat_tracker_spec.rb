require "rspec"
require './lib/stat_tracker'
require "./lib/team"

RSpec.describe StatTracker do
  let(:stat_tracker) {StatTracker.new}

  it "1. exists" do
    expect(stat_tracker).to be_a(StatTracker)
  end

  it "2. has readable attributes" do
    expect(stat_tracker.teams).to eq([])
    expect(stat_tracker.games).to eq([])
    expect(stat_tracker.game_teams).to eq([])
  end

  it "3. can parse CSV data" do
    # content = CSV.open "./data/team_dummy.csv", headers: true, header_converters: :symbol
    # expect(File).to receive(:open).with("./data/team_dummy.csv", "r", headers: true, header_converters: :symbol, :universal_newline=>false).and_return(content)
    StatTracker.team_import("./data/team_dummy.csv")
    expect(stat_tracker_1.teams[1]).to eq([1, 23, "Atlanta United", "ATL" , "Mercedes-Benz Stadium" , "/api/v1/teams/1"])
  end
end
