require_relative 'spec_helper'

RSpec.describe StatTracker do
  let(:data) do
    {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(data) }

  before(:each) do
    Season.class_variable_set :@@seasons, []
    GameTeam.class_variable_set :@@game_teams, []
    Team.class_variable_set :@@teams, []
  end
  #before :each mocks and stubs seem good here

  describe '#initialize' do
    it 'should initialize with the correct instance variables' do
      expect(stat_tracker).to be_a StatTracker
      expect(stat_tracker.data).to eq(data)
    end
  end
  
  describe '#count_of_teams' do
    it 'counts the total number of teams' do
      expect(stat_tracker.count_of_teams).to eq 32
    end
  end

  describe "#highest_total_score" do
    it 'returns the highest total score in a game through all seasons' do

      expect(stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe "#loweest_total_score" do
    it 'returns the lowest total score in a game through all seasons' do

      expect(stat_tracker.lowest_total_score).to eq(0)
    end
  end

  describe "#total_games_played" do
    it 'returns the total number of games played across all seasons' do

      expect(stat_tracker.total_games_played).to eq(7441)
    end
  end

  describe "#percentage_home_wins" do
    it 'returns the percentage of games that a home team won, to the nearest hundreth' do

      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end
  end

  describe "#percentage_visitor_wins" do
    it 'returns the percentage of games that a visiting team won, to the nearest hundreth' do

      expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe "#percentage_ties" do
    it 'returns the percentage of games that ended in a tie, to the nearest hundreth' do

      expect(stat_tracker.percentage_ties).to eq(0.2)
    end
  end

  describe "#count_of_games_by_season" do
    it 'returns a hash with each season and its game count' do
      expectation = {
        "20122013"=>806, 
        "20162017"=>1317, 
        "20142015"=>1319, 
        "20152016"=>1321, 
        "20132014"=>1323, 
        "20172018"=>1355
      }

      expect(stat_tracker.count_of_games_by_season).to be_a Hash
      expect(stat_tracker.count_of_games_by_season).to eq(expectation)
    end
  end
  
  describe "#average_goals_per_game" do
    it 'returns the average goals made per game across all seasons' do
      
      expect(stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end

  describe "#average_goals_by_season" do
    it 'returns a hash with the average goals made per game by season' do
      expectation = {
        "20122013"=>4.12, 
        "20162017"=>4.23, 
        "20142015"=>4.14, 
        "20152016"=>4.16, 
        "20132014"=>4.19, 
        "20172018"=>4.44
      }
      expect(stat_tracker.average_goals_by_season).to be_a Hash
      expect(stat_tracker.average_goals_by_season).to eq(expectation)
    end
  end
end
