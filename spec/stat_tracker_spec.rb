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

      expect(stat_tracker.game_teams[0..49]).to all(be_an_instance_of(Hash))

      expect(stat_tracker.games[0..47]).to all(be_an_instance_of(Hash))
        
      expect(stat_tracker.teams[0..32]).to all(be_an_instance_of(Hash))

    end 


    it "the objects all have the correct attributes" do 
    
      expect(stat_tracker.game_teams[0][:game_id]).to eq(2012030225)

      expect(stat_tracker.games[0][:home_goals]).to eq(1)

      expect(stat_tracker.teams[0][:team_id]).to eq(1)
    
      expect(stat_tracker.game_teams[0][:hoa]).to eq("away")

      expect(stat_tracker.game_teams[0][:faceoff_win_percentage]).to eq(50.9)

      expect(stat_tracker.games[0][:venue]).to eq("Providence Park")

      expect(stat_tracker.teams[0][:abbreviation]).to eq("ATL")

    end 
  end
  #DO NOT CHANGE ANYTHING ABOVE THIS POINT ^

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

end