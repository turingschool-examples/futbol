require 'csv'
require 'spec_helper.rb'

RSpec.describe StatTracker do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  describe "#initialize" do
    it "exists" do 
      expect(stat_tracker).to be_instance_of(StatTracker)
    end

    it "creates three arrays which house the information" do
      
      expect(stat_tracker.game_teams).to be_an_instance_of(Array)

      expect(stat_tracker.games).to be_an_instance_of(Array)

      expect(stat_tracker.teams).to be_an_instance_of(Array)
    end

    it "all of the objects in the respective arrays are of one specific object type consistent with the array" do 

      expect(stat_tracker.game_teams[0..51]).to all(be_an_instance_of(Hash))

      expect(stat_tracker.games[0..47]).to all(be_an_instance_of(Hash))
        
      expect(stat_tracker.teams[0..32]).to all(be_an_instance_of(Hash))

    end 


    it "the objects all have the correct attributes" do 
    
      expect(stat_tracker.game_teams[rand(0..51)][:game_id]).to be_a(Integer)

      expect(stat_tracker.games[rand(0..47)][:home_goals]).to be_a(Integer)

      expect(stat_tracker.teams[rand(0..32)][:team_id]).to be_a(Integer)

      expect(stat_tracker.game_teams[rand(0..51)][:faceoff_win_percentage]).to be_a(Float)

      expect(stat_tracker.games[rand(0..47)][:venue]).to be_a(String)
    end 
  end
  #DO NOT CHANGE ANYTHING ABOVE THIS POINT ^
  
  describe "Game Statisics" do
    it "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq(0.43)
    end

    it "#percentage_visitor_wins" do
      expect(stat_tracker.percentage_visitor_wins).to eq(0.43)
    end

    it "#percentage_ties" do
      expect(stat_tracker.percentage_ties).to eq(0.22)
    end
  end

  describe "League Statistics" do
    it "#highest_scoring_visitor" do
      expect(stat_tracker.highest_scoring_visitor).to eq("Philadelphia Union")
    end

    it "#highest_scoring_home_team" do
      expect(stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end

    it "#lowest_scoring_visitor" do
      expect(stat_tracker.lowest_scoring_visitor).to eq("Orlando City SC")
    end

    it "#lowest_scoring_home_team" do
      expect(stat_tracker.lowest_scoring_home_team).to eq("Seattle Sounders FC")
    end
  end
end