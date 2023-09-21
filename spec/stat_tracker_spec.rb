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
        expect(stat_tracker.highest_total_score).to eq(6)
      end 
    end
    xdescribe "#lowest total score" do 
      it 'will find the lowest sum of the winning and losing teams scores' do 
      expect(stat_tracker.lowest_total_score).to be_an(Integer)
      expect(stat_tracker.lowest_total_score).to eq(1)
      end
    end
    xdescribe "#percentage home wins" do 
      it 'will find the percentage of games that a home team has won' do 
        expect(stat_tracker.percentage_home_wins).to  be_a(Float)
        expect(stat_tracker.percentage_home_wins).to  eq()
      end
    end
    xdescribe "#percentage visitor wins" do 
      it 'will find the percentage of games that a visitor has won' do 
        expect(stat_tracker.percentage_visitor_wins).to  be_a(Float)
        expect(stat_tracker.percentage_visitor_wins).to  eq()
      end
    end
    xdescribe "#percentage_ties" do 
      it 'will find the percentage of games that ended in a tie' do 
        expect(stat_tracker.percentage_ties).to  be_a(Float)
        expect(stat_tracker.percentage_ties).to  eq()
      end
    end
    xdescribe '#count_of_games_by_season' do 
      it 'will return a A hash with season names as keys and counts of games as values' do
        expect(stat_tracker.count_of_games_by_season).to be_a(Hash)
        expect(stat_tracker.count_of_games_by_season).to eq({20122013 => 9, 20132014 => 1})
      end
    end
    xdescribe '#average_goals_per_game' do 
      it 'will return the average number of goals scored accross all seasons including both home and away goals' do 
        expect(stat_tracker.average_goals_per_game).to be_a(Float)
        expect(stat_tracker.average_goals_per_game).to eq()
      end
    end
    xdescribe '#average_goals_by_season' do 
      it 'will return a hash with season names as keys, and a float representing the average number of goals in a game for that season as values' do
        expect(stat_tracker.average_goals_by_season).to be_a(Hash)
        expect(stat_tracker.average_goals_by_season).to eq()
      end
    end
  end
end 