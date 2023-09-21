require './spec/spec_helper'

RSpec.describe StatTracker do
  before :each do
    game_path = './fixture/games_fixture.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixture/game_teams_fixture.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_stats = StatTracker.new(@locations)
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

  describe "#highest_scoring_visitor" do
    it 'finds team with highest average score when away' do
      require 'pry'; binding.pry
      expect()
    end
  end
end
