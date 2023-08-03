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

  #before :each mocks and stubs seem good here

  describe '#initialize' do
    it 'should initialize with the correct instance variables' do
      expect(stat_tracker).to be_a StatTracker
      expect(stat_tracker.data).to eq(data)
    end
  end
  
  describe '#count_of_teams' do
    it 'counts the total number of teams' do
      expect(Team.count_of_teams).to eq 32
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

      expect(stat_tracker.total_games_played).to eq(29764)
    end
  end

  describe "#percentage_home_wins" do
    it 'returns the percentage of games that a home team won, to the nearest hundreth' do

      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end
  end
end
