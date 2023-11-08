require 'spec_helper'

RSpec.describe StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    expect(stat_tracker).to be_a StatTracker
  end

  it "has a highest total points for a game" do
    stat_tracker = StatTracker.new
    expect(stat_tracker.highest_total_score).to eq(11)
  end

  it 'has a lowest total points for a game' do
    stat_tracker = StatTracker.new
    expect(stat_tracker.lowest_total_score).to eq(0)
  end

  it 'has a method to return percentage of home win games' do
    stat_tracker = StatTracker.new

    expect(stat_tracker.percentage_home_wins).to eq(0.44)
  end

  it 'has a method to return percentage of visitor win games' do
    stat_tracker = StatTracker.new

    expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
  end

  it 'has a method to return percentage of tie games' do
    stat_tracker = StatTracker.new

    expect(stat_tracker.percentage_ties).to eq(0.20)
  end
end
