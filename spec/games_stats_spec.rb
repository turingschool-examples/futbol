require 'spec_helper'

RSpec.describe GamesStats do
  before(:each) do 
    @game_stat = GamesStats.new
  end  
  describe '#initialize' do
    it 'exists' do
      expect(@game_stat).to be_a(GamesStats)
    end
  end

  describe '#highest_total_score' do
    it 'has highest_total_score' do
      expect(@game_stat.highest_total_score).to eq(11)
    end
  end
end