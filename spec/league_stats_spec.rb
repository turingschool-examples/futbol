require 'spec_helper'

RSpec.describe LeagueStats do
  before(:each) do 
    @league_stat = LeagueStats.new
  end  
  describe '#initialize' do
    it 'exists' do
      expect(@league_stat).to be_a(LeagueStats)
    end
  end

  describe '#counts teams' do
    it 'returns an integer of team count' do
      expect(@league_stat.count_of_teams).to eq(32)
    end
  end

  describe '#offenses' do
    it 'returns string of best offense' do
      expect(@league_stat.best_offense).to eq('Reign FC')
    end

    it 'returns string of worst offense' do
      expect(@league_stat.worst_offense).to eq('Utah Royals FC')
    end
  end

  describe '#highest scores' do
    it 'returns string of visitor high score' do
      expect(@league_stat.highest_scoring_visitor).to eq('FC Dallas')
    end

    it 'returns string of home team high score' do
      expect(@league_stat.highest_scoring_home_team).to eq('Reign FC')
    end
  end

  describe '#lowest scores' do
    it 'returns string of visitor low score' do
      expect(@league_stat.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end

    it 'returns string of home team low score' do
      expect(@league_stat.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end
end