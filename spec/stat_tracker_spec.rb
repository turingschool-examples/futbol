require './lib/stat_tracker'
require "csv"
require 'spec_helper'

RSpec.describe 'Stat_Tracker' do

  let(:stat_tracker) { StatTracker.new }
  let(:path) { './data/games.csv' }
  let(:path_2) { './data/teams.csv' }
  let(:path_3) { './data/game_teams.csv' }

  # it 'creates GameFactory with games as a hash' do
  #   stat_tracker = StatTracker.new
  #   stat_tracker.from_csv(path)
  #   stat_tracker.create_games_array(path).percentage_home_wins
  # end

  # it 'creates TeamFactory with team as a hash' do
  #   stat_tracker = StatTracker.new
  #   stat_tracker.from_csv(path_2)
  # end

  # it 'creates GameTeamsFactory with game team as a hash' do
  #   stat_tracker = StatTracker.new
  #   stat_tracker.from_csv(path_3)
  # end

  it "can calculate percentage of ties" do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
    expect(stat_tracker.percentage_ties).to eq(0.2)
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

  it 'can find the highest scoring visitor' do
    stat_tracker = StatTracker.new
    x = stat_tracker.from_csv(path)
    y = stat_tracker.from_csv(path_2)
    stat_tracker.highest_scoring_visitor(x, y)
  end

  it 'can check which team had the most tackles' do 
    stat_tracker = StatTracker.new
    x = stat_tracker.from_csv(path_3)
    y = stat_tracker.from_csv(path_2)
    stat_tracker.most_tackles(x, y)
  end

  it 'can check which team had the fewest tackles' do 
    stat_tracker = StatTracker.new
    x = stat_tracker.from_csv(path_3)
    y = stat_tracker.from_csv(path_2)
    stat_tracker.fewest_tackles(x, y)
  end

  it 'can check which team was the most accurate' do
    stat_tracker = StatTracker.new
    x = stat_tracker.from_csv(path_3)
    y = stat_tracker.from_csv(path_2)
    stat_tracker.most_accurate_team(x, y)
  end

  it 'can check which team was the least accurate' do
    stat_tracker = StatTracker.new
    x = stat_tracker.from_csv(path_3)
    y = stat_tracker.from_csv(path_2)
    stat_tracker.least_accurate_team(x, y)
  end
end
