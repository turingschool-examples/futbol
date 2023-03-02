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
      expect(@game_stat.percentage_ties).to eq(0.20)
    end
  end

  describe '#count_games_by_season' do
    it 'returns a hash of game counts by season' do
      expect(@game_stat.count_games_by_season).to eq({
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      })
    end
  end

  describe '#average_goals' do
    it 'can return a float value for average goals per game' do
      expect(@game_stat.average_goals_per_game).to eq(4.22)
    end
  end
end