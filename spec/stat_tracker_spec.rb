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

  describe "#count_of_games_by_season" do 
    it "#count_of_games_by_season" do
    expected = {
      "20122013"=>19,
    }
    expect(@game_stats.count_of_games_by_season).to eq expected
    end 
  end

  describe "##average_goals_by_season" do
    it "#average_goals_by_season" do
    expected = {
      "20122013"=>4 
      
    }
  expect(@game_stats.average_goals_by_season).to eq expected
end
  end


  describe "#percentage_calculator" do
    it "finds the percentage for given numbers rounded to nearest 100th" do
      expect(@game_stats.percentage_calculator(13.0, 19.0)).to eq(0.68)
      expect(@game_stats.percentage_calculator(5.0, 19.0)).to eq(0.26)
      expect(@game_stats.percentage_calculator(1.0, 19.0)).to eq(0.05)
    end
  end 


  describe '#Tackles' do
    xit 'finds most number of tackles' do
      expect(@game_stats.most_tackles).to eq(95)
    end

    xit 'finds least number of tackles' do
      expect(@game_stats.least_tackles).to eq()
    end
  end

  describe "#average_goals_per_game" do
    xit 'will find the average goals' do
      expect(@game_stats.average_goals_per_game).to eq(3.67)
      # expect(@game_stats.average_goals_per_game).to eq(4.22)
    end
  end
  
  describe "#highest_scoring_visitor" do
    xit 'finds team with highest average score when away' do
      expect(@game_stats.highest_scoring_visitor).to eq("FC Dallas")
    end
  end
  describe "#lowest_scoring_visitor" do
    xit 'finds team with lowest average score when away' do
      expect(@game_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
    end
  end
  describe "#highest_scoring_home_team" do
    xit 'finds team with highest average score when away' do
      expect(@game_stats.highest_scoring_home_team).to eq("LA Galaxy")
    end
  end
  describe "#lowest_scoring_home_team" do
    xit 'finds team with lowest average score when away' do
      expect(@game_stats.lowest_scoring_home_team).to eq("Sporting Kansas City")
    end
  end
end
