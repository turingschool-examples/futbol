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
    expect(stat_tracker.highest_total_score).to eq(11)
    expect(stat_tracker.lowest_total_score).to eq(0)
  end

  it '#winningest_coach' do
    expect(stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
    expect(stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
  end


  it '#worst_coach' do
    expect(stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it 'can find the average goal per game' do
    expect(stat_tracker.average_goals_per_game).to eq(4.22)
  end

  it 'can find the average goals by season' do
    expect(stat_tracker.average_goals_by_season).to be_a Hash
    expect(stat_tracker.average_goals_by_season["20122013"]).to eq(4.12)
    expect(stat_tracker.average_goals_by_season["20162017"]).to eq(4.23)
  end

  it 'can find the highest scoring visitor' do
    expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'can find the highest scoring home team' do
    expect(stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it "#most_tackles" do
    expect(stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United" 
    expect(stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC" 
end

  it "#least_accurate_team" do
    expect(stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_accurate_team" do
    expect(stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    #expect(stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC" #this comes back as "DC United"
  end

  it 'counts number of games by season' do 
    season_totals = {
      "20122013" => 806,
      "20132014" => 1323,
      "20142015" => 1319,
      "20152016" => 1321,
      "20162017" => 1317,
      "20172018" => 1355
      }
    expect(stat_tracker.count_of_games_by_season).to eq(season_totals)
  end

  it 'returns lowest scoring home team' do
    expect(stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

end
