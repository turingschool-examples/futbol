require './lib/stat_tracker'

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
end

