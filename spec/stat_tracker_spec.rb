require './spec_helper'




  describe '#percentage_home_wins' do
    it 'returns the percentage of games won by the home team' do
      expect(stat_tracker.percentage_home_wins).to eq(33.33)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns the percentage of games won by the visitor team' do
      expect(stat_tracker.percentage_visitor_wins).to eq(33.33)
    end
  end

  describe '#percentage_ties' do
    it 'returns the percentage of games that ended in a tie' do
      expect(stat_tracker.percentage_ties).to eq(33.33)
    end
  end
end