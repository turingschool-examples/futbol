require './lib/stat_tracker.rb'
require 'csv'

RSpec.describe StatTracker do
  describe '#initialize' do
    it 'exists' do
      stat_tracker = StatTracker.new("games_data", "teams_data", "game_teams_data")
      expect(stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  describe '#self.from_csv' do
    it '#returns an instance of stat_tracker' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)
    end
  end

  describe "percentage wins and ties methods" do
    before(:each) do 
      dummy_game_path = './data/dummy_games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: dummy_game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      @stat_tracker = StatTracker.from_csv(locations)
    end

    it "has a total_home_wins which calculates total number of home wins" do 
      expect(@stat_tracker.total_home_wins).to eq 5
    end

    it "has a total_away_wins which calculates total number of away wins" do
      expect(@stat_tracker.total_away_wins).to eq 4
    end

    it "has a total_ties which calculates total numeber of ties" do 
      expect(@stat_tracker.total_ties).to eq 0
    end

    it "has a total_games which counts the total number of games" do
      expect(@stat_tracker.total_games).to eq 9
    end
    it "has a perecentage_home_wins method which returns a float rounded to nearest 100th" do 
      expect(@stat_tracker.percentage_home_wins).to eq 0.56
    end

    it "has a perecentage_visitor_wins method which returns a float rounded to nearest 100th" do 
      expect(@stat_tracker.percentage_visitor_wins).to eq 0.44
    end

    it "has a perecentage_ties method which returns a float rounded to nearest 100th" do 
      expect(@stat_tracker.percentage_ties).to eq 0.00
    end
  end

  describe "highest total scores method" do
    before(:each) do 
      dummy_game_path = './data/dummy_games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: dummy_game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      @stat_tracker = StatTracker.from_csv(locations)
    end

    it 'highest_total_score method, sum of winning and losing team scores' do 
      expect(@stat_tracker.highest_total_score).to eq 5
    end

    it 'lowest_total_score, lowest sum of winning and losing teams scores' do 
      expect(@stat_tracker.lowest_total_score).to eq 1

    end

    it 'lowest_scoring_visitor, name of team with lowest avg score per game' do 
      expect(@stat_tracker.lowest_scoring_visitor).to eq()
    end

  end 
end
