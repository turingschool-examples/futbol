require "csv"
require "spec_helper"

RSpec.describe LeagueStatistics do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @league_stats = LeagueStatistics.new(locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@league_stats).to be_a(LeagueStatistics)
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end
  
  describe "#count_of_teams" do
    it " counts the total number of teams in the data" do    
        expect(@league_stats.count_of_teams).to be_an(Integer)
        expect(@league_stats.count_of_teams).to eq(32)
    end
  end

  describe "#best_offense" do
    xit " names the team with the highest average number of goals scored per game across all seasons" do 
        expect(@league_stats.best_offense).to be_a(String)
        # expect(@league_stats.best_offense).to eq("INSERTNAME")
    end
  end

  describe "#worst_offense" do
    xit " names the team with the lowest average number of goals scored per game across all seasons" do 
        expect(@league_stats.worst_offense).to be_a(String)
        # expect(@league_stats.teams.worst_offense).to eq("INSERTNAME")
    end
  end

  describe "#highest scoring visitor" do
    it " names the team with the highest average score per game across all seasons when they are away" do 
      expect(@league_stats.highest_scoring_visitor).to eq("FC Dallas")
      expect(@league_stats.highest_scoring_visitor).to be_a(String)
    end
  end

  describe "#highest scoring home team" do
    it "names the team with the highest average score per game across all seasons when they are home" do 
      expect(@league_stats.highest_scoring_home_team).to eq("Reign FC")
      expect(@league_stats.highest_scoring_home_team).to be_a(String)
    end
  end

  describe "#lowest scoring visitor" do
    it " names the team with the lowest average score per game across all seasons when they are away" do 
      expect(@league_stats.lowest_scoring_visitor).to eq("San Jose Earthquakes")
      expect(@league_stats.lowest_scoring_visitor).to be_a(String)
    end
  end

  describe "#lowest scoring home team" do
    it " names the team with the lowest average score per game across all seasons when they are home" do 
      expect(@league_stats.lowest_scoring_home_team).to eq("Utah Royals FC")
      expect(@league_stats.lowest_scoring_home_team).to be_a(String)
    end
  end
end
