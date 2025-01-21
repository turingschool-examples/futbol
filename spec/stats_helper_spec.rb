require './spec/spec_helper'


RSpec.describe StatsHelper do
  
  describe '#seasons' do
    it 'can return an array of the seasons' do
      expect(StatsHelper.seasons).to eq([20122013, 20162017, 20142015, 20152016, 20132014, 20172018])
    end
  end

  describe '#team_ids' do
    it 'can return an array of team IDs' do
      expect(StatsHelper.team_ids.count).to eq(32)
    end
  end

  describe '#coaches' do
    it 'can return coaches' do
      expect(StatsHelper.coaches.count).to eq(61)
    end
  end
end