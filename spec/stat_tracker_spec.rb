require 'spec_helper'

RSpec.describe StatTracker do
  describe '#initialize' do
    it 'exists' do
      stat_tracker = StatTracker.new

      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '#highest_total_score' do
    it 'returns the highest total score for a given team' do
      exp
    end
  end
end