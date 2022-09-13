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
    stat_tracker.team_import("./data/team_dummy.csv")
    expect(stat_tracker.teams[0]).to be_a Team
    expect(stat_tracker.teams[0].team_id).to eq(1)
    expect(stat_tracker.teams[0].franchise_id).to eq(23)
    expect(stat_tracker.teams[0].team_name).to eq("Atlanta United")
    expect(stat_tracker.teams[0].abbreviation).to eq("ATL")
    expect(stat_tracker.teams[0].stadium).to eq("Mercedes-Benz Stadium")
    expect(stat_tracker.teams[0].link).to eq("/api/v1/teams/1")
  end
end
