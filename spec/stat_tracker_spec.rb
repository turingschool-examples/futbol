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
    it "exists" do
      expect(@stat_tracker).to be_an(StatTracker)

    end

    it "has readable attributes" do
      # @games is an array
      # @games.first is Game object

    end
  end
  
  describe "#average_goals_per_game" do
    it "gets the average goals per game over every season, every game" do
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end
  #fixture_files = test 10 line test data

#   describe "#from_csv" do
#     it "can do all the things" do
# stat_tracker object
# game and class instances
#     initializing data at the end

#     end
#   end

  describe "#highest_total_score" do
    it "can calculate highest_total_score" do
      expect(@stat_tracker.highest_total_score).to eq(11)
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

end