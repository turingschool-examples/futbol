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

  it 'returns a hash where the keys are seasons and the values are the count of games' do
    stat_tracker = StatTracker.new

    expect(stat_tracker.count_of_games_by_season).to be_a Hash
    expect(stat_tracker.count_of_games_by_season).to eq({"20122013"=>806, "20162017"=>1317, "20142015"=>1319, "20152016"=>1321, "20132014"=>1323, "20172018"=>1355})
  end

  it "can find the average goals of all games" do
    stat_tracker = StatTracker.new

    expect(stat_tracker.average_goals_per_game).to eq(4.22)
  end

  it "can return a Hash where seasons are keys and average goals are values" do
    stat_tracker = StatTracker.new

    expect(stat_tracker.average_goals_by_season).to be_a Hash

    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44}
    expect(stat_tracker.average_goals_by_season).to eq(expected)
  end
end
