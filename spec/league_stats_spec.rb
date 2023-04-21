require 'spec_helper'

RSpec.describe 'LeagueStats' do
  before(:each) do
    @league_stats = LeagueStats.new
  end

  # league_stats tests below are basic tests that are also
  # tested in stat_tracker
  describe '#initialize' do
    it 'exists' do
      expect(@league_stats).to be_a(LeagueStats)
    end
  end

  describe '#count_of_teams' do
    it 'counts teams and returns an integer' do
      expect(@league_stats.count_of_teams).to eq(32)
    end
  
  describe '#offenses' do
    it 'returns a string of the best offense' do
      expect(@league_stats.best_offense) to eq("Reign FC")
    end
    
    it 'returns a string of the worst offense' do
      expect(@league_stats.worst_offense) to eq("Utah Royals FC") 
    end
  end

  describe '#scores' do
    it 'returns string of highest scoring visitor' do
      expect(@league_stats.highest_scoring_visitor).to eq("FC Dallas")
    end
  
    it 'returns string of highest scoring home team' do
      expect(@league_stats.highest_scoring_home_team).to eq("Reign FC")
    end

    it 'returns string of lowest scoring visitor' do
      expect(@league_stats.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end

    it 'returns string of lowest scoring home team' do 
      expect(@LeagueStats.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end

  # we will add additional tests as needed to ensure helper
  # methods are functioning correctly
  describe '#helper methods' do
  
  end

end

