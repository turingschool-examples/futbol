require './lib/stat_tracker'
require "csv"
require 'spec_helper'

RSpec.describe 'Stat_Tracker' do

  let(:game_path) { './data/games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/game_teams.csv' }

  let(:locations) do  
    {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end
  
  let(:stat_tracker) { StatTracker.from_csv(locations) }

  it 'creates GameFactory with games as a hash' do
    expect(StatTracker.create_games_factory(game_path)).to be_a(GameFactory)
  end

  it 'creates TeamFactory with team as a hash' do
    expect(StatTracker.create_teams_factory(team_path)).to be_a(TeamFactory)
  end

  it 'creates GameTeamsFactory with game team as a hash' do
    expect(StatTracker.create_game_teams_factory(game_teams_path)).to be_a(GameTeamsFactory)
  end

  it "can calculate percentage of ties" do
    expect(stat_tracker.percentage_ties).to eq(0.2)
  end
  
  context 'game_stats_methods' do
    it 'percentage home wins' do
      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it 'percentage visitor wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
    end   
  end

  context 'league_stats_methods' do
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
      expect(stat_tracker.best_offense).to eq("Sporting Kansas City") #"Reign FC"
    end
    
    it 'worst offense' do
      expect(stat_tracker.worst_offense).to eq("Reign FC")
    end #"Utah Royals FC"

    it "can find the lowest scoring visitor" do
      expect(stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
    end
  end

  it 'count_of_teams' do
    expect(stat_tracker.count_of_teams).to eq(32)
  end


  it 'sums works' do
    stat_tracker = StatTracker.new
    stat_tracker.from_csv(path)
    expect(stat_tracker.highest_sum).to eq(1262)
    expect(stat_tracker.lowest_sum).to eq(239) 

  it '#winningest_coach' do
    expect(stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
    expect(stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"

  end
end
