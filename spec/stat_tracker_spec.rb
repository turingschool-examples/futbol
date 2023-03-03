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

  describe '#team_tackles' do
    it 'returns a hash of the teams as keys and the amount of tackles in the season as the value' do
      expect(stat_tracker.team_tackles("20132014")).to be_a(Hash)
    end
  end

  describe '#most_tackles' do
    it 'can check the most tackles of a season' do
      expect(stat_tracker.most_tackles("20132014")).to eq "LA Galaxy"
      expect(stat_tracker.most_tackles("20122013")).to eq "FC Dallas"
    end
  end

  describe '#fewest_tackles' do
  describe '#fewest_tackles' do
    it 'can check the fewest tackles of a season' do
      expect(stat_tracker.fewest_tackles("20132014")).to eq "Montreal Impact"
      expect(stat_tracker.fewest_tackles("20122013")).to eq "Toronto FC"
    end
  end
end
