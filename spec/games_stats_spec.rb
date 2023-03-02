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

  describe '#lowest_total_score' do
    it 'has lowest_total_score' do
      expect(@game_stat.lowest_total_score).to eq(0)
    end
  end

  describe '#percentages' do
    it 'has percentage_home_wins' do
      expect(@game_stat.percentage_home_wins).to eq(0.44)
    end

    it 'has percentage_visitor_wins' do
      expect(@game_stat.percentage_visitor_wins).to eq(0.36)
    end

    it 'has percentage_ties' do
      expect(@games_stat.percentage_ties).to eq(0.20)
    end
  end

  
end