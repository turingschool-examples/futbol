require './lib/stat_tracker'
require "csv"
require 'spec_helper'

RSpec.describe 'Stat_Tracker' do

  let(:stat_tracker) { StatTracker.new }
  let(:path) { './data/games.csv' }
  let(:path_2) { './data/teams.csv' }
  let(:path_3) { './data/game_teams.csv' }

  it 'creates GameFactory with games as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
  end

  it 'creates TeamFactory with team as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_2)
  end
  
  it 'creates GameTeamsFactory with game team as a hash' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
  end
  
  context 'game_stats_methods' do
    before do 
      stat_tracker.from_csv(path)
    end

    it 'percentage home wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it 'percentage visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
    end   
  end

  context 'league_stats_methods' do
    let(:stat_tracker) { StatTracker.new }
    before do 
      stat_tracker.from_csv(path)
      stat_tracker.from_csv(path_2)
      stat_tracker.from_csv(path_3)
    end
    
    it 'best offense' do
      expect(stat_tracker.best_offense).to eq("Sporting Kansas City")
    end
  
  end

end
