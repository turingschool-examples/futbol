require 'spec_helper'

RSpec.describe StatTracker do
  subject(:stat_tracker) { StatTracker.new(:futbol, DATA) }

  describe '#initialize' do
    it 'exists' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  describe '::from_csv' do
    it 'instantiates the class' do
      expect(StatTracker.from_csv(LOCATIONS)).to be_a(StatTracker)
    end
  end

  describe '#league' do
    it 'has a league' do
      expect(stat_tracker.league).to be_a(League)
    end
  end

  describe '#team_tackles' do
    it 'returns a hash of the teams as keys and the amount of tackles in the season as the value' do
      expect(stat_tracker.team_tackles("20132014")).to be_a(Hash)
    end
  end

  describe '#most_tackles' do
    it 'can check the most tackles of a season' do
      expect(stat_tracker.most_tackles("20132014")).to eq("LA Galaxy")
      expect(stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
    end
  end

  describe '#fewest_tackles' do
    it 'can check the fewest tackles of a season' do
      expect(stat_tracker.fewest_tackles("20132014")).to eq("Montreal Impact")
      expect(stat_tracker.fewest_tackles("20122013")).to eq("Toronto FC")
    end
  end

  describe '#total_goals_per_game' do
    it 'can return an array of the total score for all games' do
      expect(stat_tracker.total_goals_per_game).to eq([5, 5, 3, 5, 4, 3, 5, 5, 6, 4, 3, 5, 5, 6, 4, 3, 6, 4, 3, 5, 6, 3, 4, 5, 1, 5, 6, 2, 5, 3, 4, 5, 4, 4, 4, 5, 3, 3])
    end
  end

  describe '#highest_total_score' do
    it 'can find the score of the highest scoring game' do
      expect(stat_tracker.highest_total_score).to eq(6)
    end
  end

  describe '#lowest_total_score' do
    it 'can find the total score of the lowest scoring game' do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do
    it 'can find the percentage of home wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.4474)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'can find the percentage of visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.3684)
    end
  end

  describe '#percentage_ties' do
    it 'can find the percentage of ties' do
      expect(stat_tracker.percentage_ties).to eq(0.1842)
    end
  end

end
