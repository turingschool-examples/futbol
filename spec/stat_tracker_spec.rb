require 'spec_helper'

RSpec.describe StatTracker do
  subject(:stat_tracker) { StatTracker.new(:futbol, DATA) }

  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'instantiates the class' do
      expect(StatTracker.from_csv(LOCATIONS)).to be_a(StatTracker)
    end
  end

  describe '#league' do
    it 'has a league' do
      expect(stat_tracker.league).to be_a(League)
    end
  end

  describe '#highest_total_score' do
    it "can find the highest total score of all games" do
      expect(stat_tracker.highest_total_score).to eq 6
    end
  end

  describe '#lowest_total_score' do
    xit "can find the lowest total score of all games" do
      expect(stat_tracker.lowest_total_score).to eq 1
    end
  end
end
