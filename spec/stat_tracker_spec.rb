require 'spec_helper'
require 'rspec'


RSpec.describe StatTracker do
    before(:all) do 
      game_path = './data/games.csv'
    end

      locations = {
        games: game_path
      }

      @stat_tracker = StatTracker.from_csv(locations)


  describe '#highest_total_score' do 
  it 'returns and integer' do
      expect(@stat_tracker.highest_total_score).to be_a(Integer)
    end
  end

  descrbie '#lowest_total_score' do 
    it 'returns an integer' do
      espect(@stat_tracker.lowest_total_score).to be_a(Integer)
    end
  end

  describe '#percentage_home_wins' do
    it 'returns a float' do
      expect(@stat_tracker.percentage_home_wins).to be_a(Float)
    end
  end
  
  describe '#percentage_ties' do 
    it 'returns a float' do 
      expect(@stat_tracker.percentage_ties).to be_a(Float)
    end
  end

  describe '#count_of_games_by_season' do 
    it 'returns a hash' do
      expect(@stat_tracker.count_of_games_by_season).to be_a(Hash)
    end
  end

  describe '#average_goals_per_game' do
    it 'returns a float' do 
      expect(@stat_tracker.count_of_games_per_game).to be_a(Float)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns a hash' do
      expect(@stat_tracker.average_goals_by_season).to be_a(Hash)
    end
  end
end