require 'spec_helper'

RSpec.describe SeasonStats do
  before(:each) do
    @season_stat = SeasonStats.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@season_stat).to be_a(SeasonStats)
    end
  end

  describe '#most_accurate_team' do
    it 'can return the team with the most accuracy per season' do
      expect(@stat_tracker.most_accurate_team('20132014')).to eq('Real Salt Lake')
      expect(@stat_tracker.most_accurate_team('20142015')).to eq('Toronto FC')
    end
  end

  describe '#least_accurate_team' do
    it 'can return the team with the least accuracy pr season' do
      expect(@stat_tracker.least_accurate_team('20132014')).to eq('New York City FC')
      expect(@stat_tracker.least_accurate_team('20142015')).to eq('Columbus Crew SC')
    end
  end
end