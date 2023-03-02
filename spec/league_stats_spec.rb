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