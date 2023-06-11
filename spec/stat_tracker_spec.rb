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

  it 'can find the average goal per game' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
    expect(stat_tracker.average_goals_per_game).to eq(4.22)
  end

  it 'can find the average goals by season' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
    expect(stat_tracker.average_goals_by_season).to be_a Hash
    expect(stat_tracker.average_goals_by_season["20122013"]).to eq(4.12)
    expect(stat_tracker.average_goals_by_season["20162017"]).to eq(4.23)
  end

  it 'can find the highest scoring visitor' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
    stat_tracker.from_csv(path_2)
    expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'can find the highest scoring home team' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
    stat_tracker.from_csv(path_2)
    expect(stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it 'can check which team had the most tackles' do 
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
    stat_tracker.from_csv(path_2)
    expect(stat_tracker.most_tackles).to eq("FC Cincinnati")
  end

  it 'can check which team had the fewest tackles' do 
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
    stat_tracker.from_csv(path_2)
    expect(stat_tracker.fewest_tackles).to eq("Reign FC")
  end

  it 'can check which team was the most accurate' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
    stat_tracker.from_csv(path_2)
    expect(stat_tracker.most_accurate_team).to eq("Portland Timbers")
  end

  it 'can check which team was the least accurate' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path_3)
    stat_tracker.from_csv(path_2)
    expect(stat_tracker.least_accurate_team).to eq("Sky Blue FC")
  end
end
