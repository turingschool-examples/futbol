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

  # describe "#initialize" do
  #   it "exists" do 
  #     expect(stat_tracker).to be_instance_of(StatTracker)
  #   end

  #   it "creates three arrays which house the information" do
  #     expect(stat_tracker.game_teams).to be_an_instance_of(Array)
  #     expect(stat_tracker.games).to be_an_instance_of(Array)
  #     expect(stat_tracker.teams).to be_an_instance_of(Array)
  #   end

  #   it "all of the objects in the respective arrays are of one specific object type consistent with the array" do 
  #     expect(stat_tracker.game_teams[0..51]).to all(be_an_instance_of(Hash))
  #     expect(stat_tracker.games[0..47]).to all(be_an_instance_of(Hash))
  #     expect(stat_tracker.teams[0..32]).to all(be_an_instance_of(Hash))
  #   end 

  #   it "the objects all have the correct attributes" do 
  #     expect(stat_tracker.game_teams[0][:game_id]).to eq(2012030225)
  #     expect(stat_tracker.game_teams[rand(0..51)][:game_id]).to be_a(Integer)
  #     expect(stat_tracker.games[0][:home_goals]).to eq(1)
  #     expect(stat_tracker.teams[0][:team_id]).to eq("1")
  #     expect(stat_tracker.games[0][:venue]).to eq("Providence Park")
  #     expect(stat_tracker.teams[0][:abbreviation]).to eq("ATL")
  #   end 
  # end
  
  # describe "Game Statisics" do
  #   it "#highest_total_score" do
  #     expect(stat_tracker.highest_total_score).to eq(9)
  #   end

  #   it "#lowest_total_score" do
  #     expect(stat_tracker.lowest_total_score).to eq(1)
  #   end

  #   it "#percentage_home_wins" do
  #     expect(stat_tracker.percentage_home_wins).to eq(0.39)
  #   end

  #   it "#percentage_visitor_wins" do
  #     expect(stat_tracker.percentage_visitor_wins).to eq(0.48)
  #   end

  #   it "#percentage_ties" do
  #     expect(stat_tracker.percentage_ties).to eq(0.16)
  #   end

  #   it "#count_of_games_by_season" do 
  #     expect(stat_tracker.count_of_games_by_season).to eq({
  #       "20162017" => 7, 
  #       "20172018" => 10, 
  #       "20152016" => 2, 
  #       "20142015" => 10, 
  #       "20122013" => 5, 
  #       "20132014" => 13, 
  #     })
  #   end

  #   it "#average_goals_per_game" do 
  #     expect(stat_tracker.average_goals_per_game).to eq(4.45)
  #   end

  #   it "#average_goals_by_season" do 
  #     expect(stat_tracker.average_goals_by_season).to eq({
  #       "20162017" => 5.14, 
  #       "20172018" => 4.10, 
  #       "20152016" => 6.00, 
  #       "20142015" => 3.90, 
  #       "20122013" => 5.00, 
  #       "20132014" => 4.31, 
  #     })
  #   end
  # end

  # describe "League Statistics" do
  #   it "#count_of_teams" do
  #     expect(stat_tracker.count_of_teams).to eq(32)
  #   end

  #   it "#best_offense" do
  #     expect(stat_tracker.best_offense).to eq("Reign FC")
  #   end

  #   it "#worst_offense" do
  #     expect(stat_tracker.worst_offense).to eq("Orlando City SC")
  #   end

  #   it "#away_team_goals" do
  #     expect(stat_tracker.away_team_goals).to be_a(Hash)
  #   end

  #   it "#home_team_goals" do
  #     expect(stat_tracker.home_team_goals).to be_a(Hash)
  #   end

  #   it "#highest_scoring_visitor" do
  #     expect(stat_tracker.highest_scoring_visitor).to eq("New England Revolution")
  #   end

  #   it "#highest_scoring_home_team" do
  #     expect(stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  #   end

  #   it "#lowest_scoring_visitor" do
  #     expect(stat_tracker.lowest_scoring_visitor).to eq("Orlando City SC")
  #   end

  #   it "#lowest_scoring_home_team" do
  #     expect(stat_tracker.lowest_scoring_home_team).to eq("Seattle Sounders FC")
  #   end
  # end

  describe "Season Statistics" do 
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

    it "worst coach" do 
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
    
      expect(stat_tracker.worst_coach("20152016")).to eq("Peter Laviolette").or(eq("Barry Trotz")).or(eq("Dave Hakstol")).or(eq("Michael Therrien")).or(eq("Alain Vigneault")).or(eq("Lindy Ruff"))
      expect(stat_tracker.worst_coach("20172018")).to eq("Glen Gulutzan").or(eq("Peter DeBoer")).or(eq("Mike Sullivan")).or(eq("Dave Hakstol")).or(eq("Alain Vigneault")).or(eq("Jon Cooper"))
    end

  #   it "#most_accurate_team" do
  #     game_path = './data/games.csv'
  #     team_path = './data/teams_fixture.csv'
  #     game_teams_path = './data/game_teams_fixture.csv' 
  #     locations = 
  #       {
  #       games: game_path,
  #       teams: team_path,
  #       game_teams: game_teams_path
  #     }
      
  #     stat_tracker = StatTracker.from_csv(locations)
      
  #     expect(stat_tracker.most_accurate_team("20142015")).to eq("Portland Thorns FC")
  #     expect(stat_tracker.most_accurate_team("20172018")).to eq("Portland Thorns FC")
  #   end
    
  #   it "#least_accurate_team" do
  #     game_path = './data/games.csv'
  #     team_path = './data/teams_fixture.csv'
  #     game_teams_path = './data/game_teams_fixture.csv' 
  #     locations = 
  #       {
  #       games: game_path,
  #       teams: team_path,
  #       game_teams: game_teams_path
  #     }

  #     stat_tracker = StatTracker.from_csv(locations)

  #     expect(stat_tracker.least_accurate_team("20142015")).to eq("Portland Timbers")
  #     expect(stat_tracker.least_accurate_team("20172018")).to eq("Sporting Kansas City")
  #   end

  #   it "#most_tackles" do
  #     game_path = './data/games.csv'
  #     team_path = './data/teams_fixture.csv'
  #     game_teams_path = './data/game_teams_fixture.csv' 
  #     locations = 
  #       {
  #       games: game_path,
  #       teams: team_path,
  #       game_teams: game_teams_path
  #     }

  #     stat_tracker = StatTracker.from_csv(locations)

  #     expect(stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
  #     expect(stat_tracker.most_tackles("20132014")).to eq("Houston Dynamo")
  #   end
    
  #     it "#fewest_tackles" do
  #     game_path = './data/games.csv'
  #     team_path = './data/teams_fixture.csv'
  #     game_teams_path = './data/game_teams_fixture.csv' 
  #     locations = 
  #       {
  #       games: game_path,
  #       teams: team_path,
  #       game_teams: game_teams_path
  #       }
      
  #        stat_tracker = StatTracker.from_csv(locations)

  #     expect(stat_tracker.fewest_tackles("20122013")).to eq("Montreal Impact")
  #     expect(stat_tracker.fewest_tackles("20132014")).to eq("Los Angeles FC")
  #   end
  end
  
  describe "Team Statistics" do
    it "#team_info" do
      expect(stat_tracker.team_info("6")).to eq({
        "team_id"=> "6", 
        "franchise_id"=> "6", 
        "team_name"=> "FC Dallas", 
        "abbreviation"=> "DAL", 
        "link"=> "/api/v1/teams/6"
      })
    end
    
     it "#best_season" do 
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
       expect(stat_tracker.best_season("6")).to eq("20122013")
       expect(stat_tracker.best_season("3")).to eq("20142014").or(eq("20162017"))
     end

    it "#worst_season" do 
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
      expect(stat_tracker.worst_season("6")).to eq("20132014")
      expect(stat_tracker.worst_season("3")).to eq("20122013").or(eq("20172018")).or(eq("20152016"))
    end

    it "#average_win_percentage" do
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
      expect(stat_tracker.average_win_percentage("3")).to eq(0.39)
      expect(stat_tracker.average_win_percentage("6")).to eq(0.67)
    end

    it "#most_goals_scored" do
      expect(stat_tracker.most_goals_scored("3")).to eq(5)
      expect(stat_tracker.most_goals_scored("6")).to eq(4)
    end

    it "#fewest_goals_scored" do
      expect(stat_tracker.fewest_goals_scored("3")).to eq(0)
      expect(stat_tracker.fewest_goals_scored("6")).to eq(1)
    end

    it "#favorite_opponent" do
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
      expect(stat_tracker.favorite_opponent("3")).to eq("DC United").or(eq("Real Salt Lake"))
      expect(stat_tracker.favorite_opponent("6")).to eq("Houston Dynamo").or(eq("DC United")).or(eq("New York City FC"))
    end

    it "#rival" do
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
      expect(stat_tracker.rival("3")).to eq("FC Dallas").or(eq("Orlando Pride")).or(eq("Los Angeles FC")).or(eq("Seattle Sounders FC"))
      expect(stat_tracker.rival("6")).to eq("Sporting Kansas City").or(eq("Philadelphia Union")).or(eq("Utah Royals FC"))
    end
  end
end