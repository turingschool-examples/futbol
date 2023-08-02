require 'spec_helper'

RSpec.describe LeagueStats do
  before(:each) do
    @ls = LeagueStats.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@ls).to be_a LeagueStats
    end
  end

  describe "#count_of_teams" do
    it "returns total number of teams in the data" do

    end
  end

  describe "#best_offense" do
    it "returns name of team with highest avg goals scored per game across all seasons" do

    end
  end

  describe "#worst_offense" do
    it "returns name of team with lowest avg goals per game across all seasons" do

    end
  end

  describe "#highest_scoring_visitor" do
    it "returns name of team with highest avg score per game across all seasons while away" do

    end
  end

  describe "#highest_scoring_home_team" do
    it "returns name of team with highest avg score per game across all seasons while home" do

    end
  end

  describe "#lowest_scoring_visitor" do
    it "returs name of team with lowest avg score per game across all seasons while a visitor" do

    end
  end

  describe "#lowest_scoring_home_team" do
    it "returns name of team with lowest avg score per game across all seasons while home" do
      
    end
  end
end