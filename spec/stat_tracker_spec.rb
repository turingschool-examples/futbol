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

  describe '#get_reg_and_post_seasons' do
    it 'returns an array' do
      expect(stat_tracker.get_reg_and_post_seasons("20132014")).to be_a(Array)
    end
  end

  describe '#most_tackes' do
    it 'can check the most tackles of a season' do
      expect(stat_tracker.most_tackles("20132014")).to eq "LA Galaxy"
      expect(stat_tracker.most_tackles("20122013")).to eq "FC Dallas"
    end
  end
end
