require 'spec_helper'

RSpec.describe StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    expect(stat_tracker).to be_a StatTracker
  end

  it "has a highest total points for a game" do
    stat_tracker = StatTracker.new
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  it 'has a lowest total points for a game' do
    stat_tracker = StatTracker.new
    expect(stat_tracker.lowest_total_score).to eq(1)
  end
end
