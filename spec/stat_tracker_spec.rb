require './lib/stat_tracker'
require 'spec_helper'
require 'rspec'


RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe "initialize" do
    it "has readable attributes" do
      expect(@stat_tracker.games).to be_an(Array)
      expect(@stat_tracker.games.first).to be_a(Game)
      expect(@stat_tracker.teams).to be_an(Array)
      expect(@stat_tracker.teams.first).to be_a(Team)
      expect(@stat_tracker.game_teams).to be_an(Array)
      expect(@stat_tracker.game_teams.first).to be_a(GameTeams)
    end
  end

  describe "self.from_csv" do
    it "exists" do
      expect(@stat_tracker).to be_an(StatTracker)
    end

    it "parses games" do
      expect(@stat_tracker.games.length).to satisfy { |n| n > 1 }
      expect(@stat_tracker.games[0]).to be_a(Game)
    end

    it "parses teams" do
      expect(@stat_tracker.teams.length).to satisfy { |n| n > 1 }
      expect(@stat_tracker.teams[0]).to be_a(Team)
    end

    it "parses game_teams" do
      expect(@stat_tracker.game_teams.length).to satisfy { |n| n > 1 }
      expect(@stat_tracker.game_teams[0]).to be_a(GameTeams)
    end
  end

  describe "#highest_total_score" do
    it "can calculate highest_total_score" do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe "#average_goals_per_game" do
    it "gets the average goals per game over every season, every game" do
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end

  describe "#average_goals_by_season" do
    it "it calculates average goals per game by season" do
        expected = {
          "20122013"=>4.12,
          "20162017"=>4.23,
          "20142015"=>4.14,
          "20152016"=>4.16,
          "20132014"=>4.19,
          "20172018"=>4.44
        }
        expect(@stat_tracker.average_goals_by_season).to eq(expected)
    end
  end

  describe "#lowest_total_score" do
    it "can calculate lowest_total_score" do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end


  describe "#count_of_games_by_season" do
    it "can calculate count_of_games_by_season" do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe "#percentage_home_wins" do
    it "gets Percentage of games that a home team has won" do
      expect(@stat_tracker.percentage_home_wins).to(eq 0.44)
    end
  end

  describe "#percentage_visitor_wins" do
    it "gets Percentage of games that a visitor team has won" do
        expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe "#count of teams" do
    it "returns the total amount of teams in data" do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe "#best_offense" do
    it "returns name of the team with the highest average number of goals scored per game across all seasons" do
      expect(@stat_tracker.best_offense).to eq("Reign FC")
    end
  end

  describe "#worst_offesne" do
    it "returns name of the team with the lowest average number of goals scored per game across all seasons" do
      expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
    end
  end

  describe "#lowest_scoring_home_team" do
    it "returns name of the team with the lowest average number of goals scored per home game" do
        expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end

  #helper methods
  describe "#total_goals" do
    it "returns hash of home/away_team_id and total goals" do
      expect(@stat_tracker.total_goals.keys.count).to eq(@stat_tracker.count_of_teams)
      expect(@stat_tracker.total_goals["6"]).to eq(1154)
    end
  end

  describe "total_games" do
    it "returns a hash of home/away team_id and total games played" do
      expect(@stat_tracker.total_goals.keys.count).to eq(@stat_tracker.count_of_teams)
      expect(@stat_tracker.total_games["3"]).to eq(531)
      # establishes that the number of teams equals the number of keys but probably needs something else to establish truth?
    end
  end

  describe "averages_id_by_goals_games" do
    it "returns hash of home/away team_id and average goals per game" do
      expect(@stat_tracker.averages_id_by_goals_games.keys.count).to eq(@stat_tracker.count_of_teams)
      expect(@stat_tracker.averages_id_by_goals_games["6"]).to eq(2.2627450980392156)
    end
  end
end