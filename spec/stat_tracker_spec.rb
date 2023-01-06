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
    
      expect(stat_tracker.game_teams[0][:game_id]).to eq(2012030225)

      expect(stat_tracker.game_teams[rand(0..51)][:game_id]).to be_a(Integer)

      expect(stat_tracker.games[0][:home_goals]).to eq(1)

      expect(stat_tracker.teams[0][:team_id]).to eq(1)

      expect(stat_tracker.games[0][:venue]).to eq("Providence Park")

      expect(stat_tracker.teams[0][:abbreviation]).to eq("ATL")

    end 
  end
  #DO NOT CHANGE ANYTHING ABOVE THIS POINT ^
  
  describe "Game Statisics" do
    it "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq(0.43)
    end


    it "counts the games by season" do 

      expect(stat_tracker.count_of_games_by_season).to eq({
        "20162017" => 7, 
        "20172018" => 10, 
        "20152016" => 2, 
        "20142015" => 10, 
        "20122013" => 5, 
        "20132014" => 13, 
      })
    end

    it "is able to find the average number of goals across all seasons" do 
      expect(stat_tracker.average_goals_per_game).to eq(4.45)
    end

    it "Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)" do 
      expect(stat_tracker.average_goals_by_season).to eq({
        
        "20162017" => 5.14, 
        "20172018" => 4.10, 
        "20152016" => 6.00, 
        "20142015" => 3.90, 
        "20122013" => 5.00, 
        "20132014" => 4.31, 

      })
    end
    context "Season Statistics" do 
    it "winningest_coach" do 
      game_path = './data/games.csv'
      team_path = './data/teams_fixture.csv'
      game_teams_path = './data/game_teams_fixture.csv' 
      locations = 
        {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      
      stat_tracker = StatTracker.from_csv(locations) 

      expect(stat_tracker.winningest_coach("20152016")).to eq("Ken Hitchcock")
      expect(stat_tracker.winningest_coach("20122013")).to eq("Alain Vigneault")
      expect(stat_tracker.winningest_coach("20172018")).to eq("Peter Laviolette").or(eq("Gerard Gallant")).or(eq("Paul Maurice"))
    end

    # it "worst coach" do 
    #   game_path = './data/games.csv'
    #   team_path = './data/teams_fixture.csv'
    #   game_teams_path = './data/game_teams_fixture.csv' 
    #   locations = 
    #     {
    #     games: game_path,
    #     teams: team_path,
    #     game_teams: game_teams_path
    #     }
      
    #   stat_tracker = StatTracker.from_csv(locations) 
    
    #   expect(stat_tracker.worst_coach("20152016")).to eq("Peter Laviolette").or(eq("Barry Trotz"))
    #   expect(stat_tracker.worst_coach("20172018")).to eq("Glen Gulutzan").or(eq("Peter DeBoer")).or(eq("Mike Sullivan"))


    # end
      end 


  describe "Game Statistics" do
    it "#highest_total_score" do
      expect(stat_tracker.highest_total_score).to eq(9)
    end

    it "#lowest_total_score" do
      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  describe "League Statistics" do
    it "#count_of_teams" do
      expect(stat_tracker.count_of_teams).to eq(32)
    end

    it "#best_offense" do
      expect(stat_tracker.best_offense).to eq("Reign FC")
    end

    it "#worst_offense" do
      expect(stat_tracker.worst_offense).to eq("Orlando City SC")
    end
  end

  describe "Season Statistics" do
    xit "#most_accurate_team" do
      expect(stat_tracker.most_accurate_team).to eq()
    end

    xit "#least_accurate_team" do
      expect(stat_tracker.least_accurate_team).to eq()
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