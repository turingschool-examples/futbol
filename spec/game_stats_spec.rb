require 'spec_helper'

RSpec.describe GameStats do
  describe 'highest and lowest total scores' do
    it "#highest_total_score" do
      expect(GameStats.highest_total_score).to eq(11)
    end
  
    it "#lowest_total_score" do
      expect(GameStats.lowest_total_score).to eq(0)
    end
  end
end