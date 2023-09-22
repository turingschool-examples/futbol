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


  describe '#Tackles' do
    xit 'finds most number of tackles' do
      expect(@game_stats.most_tackles).to eq(95)
    end

    xit 'finds least number of tackles' do
      expect(@game_stats.least_tackles).to eq()
    end
  end

  describe "#average_goals_per_game" do
    it 'will find the average goals' do
      expect(@game_stats.average_goals_per_game).to eq(3.67)
      # expect(@game_stats.average_goals_per_game).to eq(4.22)
    end
  end

  describe "#team_goals" do 
    it 'will find the amount of goals per team' do
      expect(@game_stats.team_goals).to be_instance_of(Hash)
      expect(@game_stats.team_goals).to eq({"3"=>8, "6"=>24, "5"=>2, "17"=>6, "16"=>4})
    end
  end
  
  describe "#games_by_team" do 
    it 'will find the amount of home games per team' do
      expect(@game_stats.games_by_team("home")).to be_instance_of(Hash)
      expect(@game_stats.games_by_team("home")).to eq({"3"=>2, "6"=>5, "5"=>2, "17"=>1, "16"=>2})
    end
    it 'will find the amount of away games per team' do
      expect(@game_stats.games_by_team("away")).to be_instance_of(Hash)
      expect(@game_stats.games_by_team("away")).to eq({"3"=>3, "6"=>4, "5"=>2, "17"=>2, "16"=>1})
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
