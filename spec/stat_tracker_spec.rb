require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  it "Test 1: exists" do
    tracker = StatTracker.new

    expect(tracker).to be_a(StatTracker)
  end

  it "has a total number of games played" do
    tracker = StatTracker.new

    expect(tracker.total_games).to eq 14882
  end

  # it "#percentage_home_wins" do
  #   tracker = StatTracker.new

  #   expect(tracker.percentage_home_wins).to eq .44
  # end
end