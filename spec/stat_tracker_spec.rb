require './spec/spec_helper'

RSpec.describe StatTracker do
  before :each do
    game_path = './data/games.csv'
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
      expect(@game_stats.percentage_ties).to eq(0.20)
    end
  end

  describe "#count_of_games_by_season" do 
    it "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355

    }
    expect(@game_stats.count_of_games_by_season).to eq expected
    end 
  end

  describe "##average_goals_by_season" do
    it "#average_goals_by_season" do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(@game_stats.average_goals_by_season).to eq expected
    end
  end

  it "#percentage_visitor_wins" do 
    expect(@game_stats.percentage_visitor_wins).to eq 0.0
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

    it 'will find the average goals' do
      #this test is for the fixture

      expect(@game_stats.average_goals_per_game).to eq(3.67)
      #this test is for the full data
      # expect(@game_stats.average_goals_per_game).to eq(4.22)
    end
  end

  describe "#team_goals" do 
    it 'will find the amount of goals per team' do
      expect(@game_stats.team_goals("home")).to be_instance_of(Hash)
      #this test is for the fixture
      expect(@game_stats.team_goals("away")).to eq({"3"=>5, "6"=>12, "5"=>1, "17"=>3, "16"=>1})
      expect(@game_stats.team_goals("home")).to eq({"3"=>3, "6"=>12, "5"=>1, "17"=>3, "16"=>3})

    end
  end
  describe "#games_by_team" do 
    it 'will find the amount of home games per team' do
      expect(@game_stats.games_by_team("home")).to be_instance_of(Hash)
      #this test is for the fixture
      expect(@game_stats.games_by_team("home")).to eq({"3"=>2, "6"=>5, "5"=>2, "17"=>1, "16"=>2})
    end

    it 'will find the amount of away games per team' do
      expect(@game_stats.games_by_team("away")).to be_instance_of(Hash)
      #this test is for the fixture
      expect(@game_stats.games_by_team("away")).to eq({"3"=>3, "6"=>4, "5"=>2, "17"=>2, "16"=>1})
    end
  end
  
  describe "#highest_scoring_visitor" do
    it 'finds team with highest average score when away' do
    #this test is for the fixture
    expect(@game_stats.highest_scoring_visitor).to eq("FC Dallas")
  end
end
  describe "#lowest_scoring_visitor" do
    xit 'finds team with lowest average score when away' do
  #this test is for the fixture
  expect(@game_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
end
end
describe "#highest_scoring_home_team" do
xit 'finds team with highest average score when away' do
  #this test is for the fixture
      expect(@game_stats.highest_scoring_home_team).to eq("LA Galaxy")
    end
  end
  describe "#lowest_scoring_home_team" do
    xit 'finds team with lowest average score when away' do
      expect(@game_stats.lowest_scoring_home_team).to eq("Sporting Kansas City")
    end
  end
end