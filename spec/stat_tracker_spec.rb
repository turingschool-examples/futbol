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

    it 'counts goals per team' do
      expected = {
        "3"=>1129,
        "6"=>1154,
        "5"=>1262,
        "17"=>1007,
        "16"=>1156,
        "9"=>1038,
        "8"=>1019,
        "30"=>1062,
        "26"=>1065,
        "19"=>1068,
        "24"=>1146,
        "2"=>1053,
        "15"=>1168,
        "20"=>978,
        "14"=>1159,
        "28"=>1128,
        "4"=>972,
        "21"=>973,
        "25"=>1061,
        "13"=>955,
        "18"=>1101,
        "10"=>1007,
        "29"=>1029,
        "52"=>1041,
        "54"=>239,
        "1"=>896,
        "23"=>923,
        "12"=>936,
        "27"=>263,
        "7"=>841,
        "22"=>964,
        "53"=>620
      }
      expect(stat_tracker.goals_per_team).to eq(expected)
    end
    
    it 'best offense' do
      expect(stat_tracker.best_offense).to eq("Sporting Kansas City")
    end

    it 'worst offense' do
      expect(stat_tracker.worst_offense).to eq("Reign FC")
    end
  
  end

end
