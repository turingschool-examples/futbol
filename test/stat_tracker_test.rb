require "test_helper.rb"
require_relative "../lib/stat_tracker.rb"


describe StatTracker do
  let(:stat) {StatTracker.new}

  it "should exist" do
    expect(stat).to be_kind_of(StatTracker)
  end

  it "should return 0 if left alone" do
    expect(stat.wins).to eq(0)
  end

  it "should return the number assigned to it" do
    stat.wins = 5

    expect(stat.wins).to eq(5)
  end
end
