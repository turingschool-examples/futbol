require 'spec_helper'
RSpec.describe StatTracker do
  let(:game_path) { './data/test_games.csv' }
  let(:team_path) { './data/teams.csv' } 
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
    it 'will create an array of Team objects to be used by the StatTracker' do 
      expect(stat_tracker.teams).to be_a(Array)
      expect(stat_tracker.teams.first).to be_a(Team)
    end
    it 'will create an array of Game objects to be used by the StatTracker' do 
      expect(stat_tracker.games).to be_a(Array)
      expect(stat_tracker.games.first).to be_a(Game)
    end
    it 'will create an array of GameTeam objects to be used by the StatTracker' do 
      expect(stat_tracker.game_teams).to be_a(Array)
      expect(stat_tracker.game_teams.first).to be_a(GameTeam)
    end
  end
  context 'Game Statistic Methods' do
    describe "#highest total score" do 
      it 'will find the highest sum of the winning and losing teams scores and return them as integers' do
        expect(stat_tracker.highest_total_score).to be_an(Integer)
        expect(stat_tracker.highest_total_score).to eq(7)
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
        expect(stat_tracker.percentage_home_wins).to  eq(68.0)
      end
    end
    describe "#percentage visitor wins" do 
      it 'will find the percentage of games that a visitor has won' do 
        expect(stat_tracker.percentage_visitor_wins).to  be_a(Float)
        expect(stat_tracker.percentage_visitor_wins).to  eq(30.0)
      end
    end
    describe "#percentage_ties" do 
      it 'will find the percentage of games that ended in a tie' do 
        expect(stat_tracker.percentage_ties).to  be_a(Float)
        expect(stat_tracker.percentage_ties).to  eq(2.00)
      end
    end
    describe '#count_of_games_by_season' do 
      it 'will return a A hash with season names as keys and counts of games as values' do
        expect(stat_tracker.count_of_games_by_season).to be_a(Hash)
        expect(stat_tracker.count_of_games_by_season).to eq({20122013=>57, 20162017=>4, 20142015=>6, 20152016=>6})
      end
    end
    describe '#average_goals_per_game' do 
      it 'will return the average number of goals scored accross all seasons including both home and away goals' do 
        expect(stat_tracker.average_goals_per_game).to be_a(Float)
        expect(stat_tracker.average_goals_per_game).to eq(3.95)
      end
    end
    xdescribe '#average_goals_by_season' do 
      it 'will return a hash with season names as keys, and a float representing the average number of goals in a game for that season as values' do
        expect(stat_tracker.average_goals_by_season).to be_a(Hash)
        expect(stat_tracker.average_goals_by_season).to eq(2)
      end
    end
  end

  context 'Season Statistic Methods' do
    describe "#winningest_coach" do 
      it 'will find the coach with the highest win percentage' do
        expect(stat_tracker.winningest_coach).to be_an(String)
        expect(stat_tracker.winningest_coach).to eq("Claude Julien")
      end 
    end
  end
end 