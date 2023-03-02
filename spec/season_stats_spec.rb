require 'spec_helper'

RSpec.describe SeasonStats do
  before(:each) do 
    @season_stat = SeasonStats.new
  end
  describe '#initialize' do
    it 'exists' do
      expect(@season_stat).to be_a SeasonStats
    end
  end

  describe '#coach methods' do 
    it '#winningest_coach' do
      expect(@season_stat.winningest_coach('20132014')).to eq('Claude Julien')
      expect(@season_stat.winningest_coach('20142015')).to eq('Alain Vigneault')
    end 

    xit '#worst_coach' do
    expect(@season_stat.worst_coach('20132014')).to eq('Peter Laviolette')
    expect(@season_stat.worst_coach('20142015')).to eq('Craig MacTavish').or(eq('Ted Nolan'))
  end
  end

end