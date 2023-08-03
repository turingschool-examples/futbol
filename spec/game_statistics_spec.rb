require "spec_helper"

RSpec.describe GameStatistics do
  before :each do
    @game_path = './fixture/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixture/game_teams_fixture.csv'
    
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @game_stats = GameStatistics.new(@locations)
  end

  describe "#initialize" do
    it 'exists' do
      expect(@game_stats).to be_a GameStatistics
    end
  end

  describe "#highest_total_score" do
    it "finds the highest total score from stat data" do
      expect(@game_stats.highest_total_score).to eq(5)
    end
  end

  describe "lowest_total_score" do
    it "finds the lowest total score from stat data" do
      expect(@game_stats.lowest_total_score).to eq(1)
    end
  end

  describe "#percentage_home_wins" do
    it "finds percentage of games that a home team has won(rounded to nearedst 100th)" do
      expect(@game_stats.percentage_home_wins).to eq(0.68)
    end
  end

  describe "#percentage_visitor_wins" do
    it "finds percentage of games that a visitor team has won(rounded to nearedst 100th)" do
      expect(@game_stats.percentage_visitor_wins).to eq(0.26)
    end
  end

  describe "#percent ties" do
    it "finds percntage of tied away and home games" do
      expect(@game_stats.percentage_ties).to eq(0.05)
    end
  end

  describe "#percentage_calculator" do
    it "finds the percentage for given numbers rounded to nearest 100th" do
      expect(@game_stats.percentage_calculator(13.0, 19.0)).to eq(0.68)
      expect(@game_stats.percentage_calculator(5.0, 19.0)).to eq(0.26)
      expect(@game_stats.percentage_calculator(1.0, 19.0)).to eq(0.05)
    end
  end
end