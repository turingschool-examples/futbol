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
      dummy_team_path = './data/dummy_teams.csv'
      dummy_game_teams_path = './data/dummy_game_teams.csv'
      locations = {
        games: dummy_game_path,
        teams: dummy_team_path,
        game_teams: dummy_game_teams_path
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

  describe 'average goal methods'do
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
    it 'has a average_goals_per_game method which returns a float rounded to nearest 100th' do
      expect(@stat_tracker.average_goals_per_game).to eq 3.78
    end

    it 'has average_goals_by_season method which returns a hash' do
      expect(@stat_tracker.average_goals_by_season).to eq ({20122013 => 3.78})
    end
  end

  describe "winningest and worst coaches methods" do 
    before(:each) do 
      dummy_game_path = './data/dummy_games.csv'
      dummy_team_path = './data/dummy_teams.csv'
      dummy_game_teams_path = './data/dummy_game_teams.csv'
      locations = {
        games: dummy_game_path,
        teams: dummy_team_path,
        game_teams: dummy_game_teams_path
      }
      @stat_tracker = StatTracker.from_csv(locations)
    end
  
    it "has games_by_season which returns an array of games_ids" do 
      expect(@stat_tracker.games_by_season("20122013")).to eq ["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314"]
    end
  
    it "has data_by_season which returns an array of game_teams_data rows" do 
      expect(@stat_tracker.data_by_season("20122013")).to be_an Array
      coaches = @stat_tracker.data_by_season("20122013").map { |row| row["head_coach"] }
      expect(coaches).to eq ["John Tortorella", "Claude Julien", "John Tortorella", "Claude Julien", "Claude Julien", "John Tortorella", "Claude Julien", "John Tortorella", "John Tortorella"]
    end
  
    it "has wins_by_coach which returns hash with coach key and no. wins value" do 
      expect(@stat_tracker.wins_by_coach("20122013")).to be_a Hash
      expect(@stat_tracker.wins_by_coach("20122013")["John Tortorella"]).to eq 0
      expect(@stat_tracker.wins_by_coach("20122013")["Claude Julien"]).to eq 4
    end
  
    it "has sorted_wins_by_coach which returns a nested array sorting wins_by_coach by wins" do 
      expect(@stat_tracker.sorted_wins_by_coach("20122013")).to be_an Array
      max_wins = @stat_tracker.wins_by_coach("20122013").values.max 
      min_wins = @stat_tracker.wins_by_coach("20122013").values.min 
      expect(@stat_tracker.sorted_wins_by_coach("20122013")[0][1]).to eq max_wins
      expect(@stat_tracker.sorted_wins_by_coach("20122013")[-1][1]).to eq min_wins
    end
  
    it "has winningest_coach which returns the name of winningest coach as a string" do 
      expect(@stat_tracker.winningest_coach("20122013")).to eq "Claude Julien"
    end
  
    it "has worst_coach which returns the name of the worst coach as a string" do 
      expect(@stat_tracker.worst_coach("20122013")).to eq "John Tortorella"
    end
  end
end
