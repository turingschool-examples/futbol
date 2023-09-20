require 'spec_helper'
RSpec.describe StatTracker do
  let(:game_path) { './data/test_games.csv' }
  let(:team_path) { './data/test_teams.csv' } 
  let(:game_teams_path) { './data/test_game_teams.csv' } 
  let(:test_locations) { 
    {games: game_path,
    teams: team_path,
    game_teams: game_teams_path}
    } 
  let(:stat_tracker) { StatTracker.from_csv(test_locations) } 

  describe "::from_csv" do 
    it 'will create a new instance of StatTracker using data from the given csv' do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end
  describe "#highest total score" do 
    it 'will find the highest sum of the winning and losing teams scores and return them as integers' do
      expect(stat_tracker.highest_total_score).to be_an(Integer)
      expect(stat_tracker.highest_total_score).to eq(6)
    end 
  end
  describe "#lowest total score" do 
    it 'will find the lowest sum of the winning and losing teams scores' do 
     expect(stat_tracker.lowest_total_score).to be_an(Integer)
     expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end
  describe "#percentage home wins" do 
    it 'will find the percentage of games that a home team has won' do 
      expect(stat_tracker.percentage_home_wins).to  be_a(Float)
      expect(stat_tracker.percentage_home_wins).to  eq(0.6)
    end
  end
  describe "#percentage visitor wins" do 
    it 'will find the percentage of games that a visitor has won' do 
      expect(stat_tracker.percentage_visitor_wins).to  be_a(Float)
      expect(stat_tracker.percentage_visitor_wins).to  eq(0.4)
    end
  end
  describe "#percentage_ties" do 
    xit 'will find the percentage of games that ended in a tie' do 
      expect(stat_tracker.percentage_ties).to  be_a(Float)
      expect(stat_tracker.percentage_ties).to  eq()
    end
  end
end 