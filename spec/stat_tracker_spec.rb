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

  it "#percentage_home_wins" do 
    expect(@game_stats.percentage_home_wins).to eq 0.0
  end


  describe "#percentage_calculator" do
    it "finds the percentage for given numbers rounded to nearest 100th" do
      expect(@game_stats.percentage_calculator(13.0, 19.0)).to eq(0.68)
      expect(@game_stats.percentage_calculator(5.0, 19.0)).to eq(0.26)
      expect(@game_stats.percentage_calculator(1.0, 19.0)).to eq(0.05)
    end
  end
    
    it 'helper methods' do
      expect(@game_stats.seasons_sorted).to be_a(Hash)
      expect(@game_stats.team_info).to be_a(Hash)
    end
    
    describe '#Tackles' do
    it 'finds most number of tackles' do
      #fixture test
      expect(@game_stats.most_tackles("20122013")).to eq "FC Dallas"

      #full data test
      expect(@game_stats.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@game_stats.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it 'finds least number of tackles' do
      #fixture test
      expect(@game_stats.fewest_tackles("20122013")).to eq "Chicago Fire"
    
    #full data test
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end

  describe '#Team accuracy' do
    it 'check the most accurate team for a season' do
      #fixture test
      expect(@game_stats.most_accurate_team("20122013")).to eq("Chicago Fire")

      #full data test
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end
  end

  describe "#average_goals_per_game" do

    xit 'will find the average goals' do

    it 'will find the average goals' do
      #this test is for the fixture

      expect(@game_stats.average_goals_per_game).to eq(3.67)
      #this test is for the full data
      expect(@game_stats.average_goals_per_game).to eq(4.22)
    end
  end

  describe "#team_goals" do 
    xit 'will find the amount of goals per team' do
      expect(@game_stats.team_goals("home")).to be_instance_of(Hash)
      #this test is for the fixture
      expect(@game_stats.team_goals("away")).to eq({"3"=>5, "6"=>12, "5"=>1, "17"=>3, "16"=>1})
      expect(@game_stats.team_goals("home")).to eq({"3"=>3, "6"=>12, "5"=>1, "17"=>3, "16"=>3})

    end
  end
  describe "#games_by_team" do 
    xit 'will find the amount of home games per team' do
      expect(@game_stats.games_by_team("home")).to be_instance_of(Hash)
      #this test is for the fixture
      expect(@game_stats.games_by_team("home")).to eq({"3"=>2, "6"=>5, "5"=>2, "17"=>1, "16"=>2})
    end

    xit 'will find the amount of away games per team' do
      expect(@game_stats.games_by_team("away")).to be_instance_of(Hash)
      #this test is for the fixture
      expect(@game_stats.games_by_team("away")).to eq({"3"=>3, "6"=>4, "5"=>2, "17"=>2, "16"=>1})
    end
  end
  
  describe "#average_goals_per_team" do
    xit "calculates average away goals per team" do
      expect(@game_stats.average_goals_per_team("away")).to eq({"3"=>1.67, "6"=>3.0, "5"=>0.5, "17"=>1.5, "16"=>1.0})
    end
    xit "calculates average home goals per team" do
      expect(@game_stats.average_goals_per_team("home")).to eq({"3"=>1.5, "6"=>2.4, "5"=>0.5, "17"=>3, "16"=>1.5})
    end
  end

  describe "#highest_scoring_visitor" do
    it 'finds team with highest average score when away' do
    #this test is for the fixture
    # expect(@game_stats.highest_scoring_visitor).to eq("FC Dallas")
    expect(@game_stats.highest_scoring_visitor).to eq("6")
    #for full data
    # expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end
  end
    describe "#lowest_scoring_visitor" do
      it 'finds team with lowest average score when away' do
    #this test is for the fixture
    # expect(@game_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
    # expect(@game_stats.lowest_scoring_visitor).to eq("5")
    #for full data
    expect(@game_stats.lowest_scoring_visitor).to eq("27")
    # expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end
  end
  describe "#highest_scoring_home_team" do
  it 'finds team with highest average score when away' do
    #this test is for the fixture
        # expect(@game_stats.highest_scoring_home_team).to eq("LA Galaxy")
        # expect(@game_stats.highest_scoring_home_team).to eq("17")
        #for full data
        expect(@game_stats.highest_scoring_home_team).to eq("54")
        # expect(@stat_tracker.lowest_scoring_visitor).to eq "Reign FC"
      end
    end

    describe "#lowest_scoring_home_team" do
      it 'finds team with lowest average score when away' do
        # expect(@game_stats.lowest_scoring_home_team).to eq("Sporting Kansas City")
        # expect(@game_stats.lowest_scoring_home_team).to eq("5")
        #for full data
        expect(@game_stats.lowest_scoring_home_team).to eq("7")
        # expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
      end
    end

    describe "#count of teams" do
      it 'tells total number of teams' do
        expect(@game_stats.count_of_teams).to be_instance_of(Integer)
        expect(@game_stats.count_of_teams).to eq 32
      end
    end
  end
end

it "exists" do
  expect(@stat_tracker).to be_an_instance_of StatTracker
end

it "#highest_total_score" do
  expect(@stat_tracker.highest_total_score).to eq 11
end

it "#lowest_total_score" do
  expect(@stat_tracker.lowest_total_score).to eq 0
end

it "#percentage_home_wins" do
  expect(@stat_tracker.percentage_home_wins).to eq 0.44
end

#   it "#percentage_visitor_wins" do
#     expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
#   end

#   it "#percentage_ties" do
#     expect(@stat_tracker.percentage_ties).to eq 0.20
#   end

#   it "#count_of_games_by_season" do
#     expected = {
#       "20122013"=>806,
#       "20162017"=>1317,
#       "20142015"=>1319,
#       "20152016"=>1321,
#       "20132014"=>1323,
#       "20172018"=>1355
#     }
#     expect(@stat_tracker.count_of_games_by_season).to eq expected
#   end

#   it "#average_goals_per_game" do
#     expect(@stat_tracker.average_goals_per_game).to eq 4.22
#   end

#   it "#average_goals_by_season" do
#     expected = {
#       "20122013"=>4.12,
#       "20162017"=>4.23,
#       "20142015"=>4.14,
#       "20152016"=>4.16,
#       "20132014"=>4.19,
#       "20172018"=>4.44
#     }
#     expect(@stat_tracker.average_goals_by_season).to eq expected
#   end

#   it "#count_of_teams" do
#     expect(@stat_tracker.count_of_teams).to eq 32
#   end

#   it "#best_offense" do
#     expect(@stat_tracker.best_offense).to eq "Reign FC"
#   end

#   it "#worst_offense" do
#     expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
#   end

#   it "#highest_scoring_visitor" do
#     expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
#   end

#   it "#highest_scoring_home_team" do
#     expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
#   end

#   it "#lowest_scoring_visitor" do
#     expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
#   end

#   it "#lowest_scoring_home_team" do
#     expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
#   end

#   it "#team_info" do
#     expected = {
#       "team_id" => "18",
#       "franchise_id" => "34",
#       "team_name" => "Minnesota United FC",
#       "abbreviation" => "MIN",
#       "link" => "/api/v1/teams/18"
#     }

#     expect(@stat_tracker.team_info("18")).to eq expected
#   end

#   it "#best_season" do
#     expect(@stat_tracker.best_season("6")).to eq "20132014"
#   end

#   it "#worst_season" do
#     expect(@stat_tracker.worst_season("6")).to eq "20142015"
#   end

#   it "#average_win_percentage" do
#     expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
#   end

#   it "#most_goals_scored" do
#     expect(@stat_tracker.most_goals_scored("18")).to eq 7
#   end

#   it "#fewest_goals_scored" do
#     expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
#   end

#   it "#favorite_opponent" do
#     expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
#   end

#   it "#rival" do
#     expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
#   end

#   it "#winningest_coach" do
#     expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
#     expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
#   end

#   it "#worst_coach" do
#     expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
#     expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
#   end

#   it "#most_accurate_team" do
#     expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
#     expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
#   end

#   it "#least_accurate_team" do
#     expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
#     expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
#   end

#   it "#most_tackles" do
#     expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
#     expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
#   end

#   it "#fewest_tackles" do
#     expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
#     expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
#   end
end

#   describe "#percent ties" do
#     it "finds percntage of tied away and home games" do
#       expect(@game_stats.percentage_ties).to eq(0.05)
#     end
#   end

#   describe "#percentage_calculator" do
#     it "finds the percentage for given numbers rounded to nearest 100th" do
#       expect( .percentage_calculator(13.0, 19.0)).to eq(0.68)
#       expect(@game_stats.percentage_calculator(5.0, 19.0)).to eq(0.26)
#       expect(@game_stats.percentage_calculator(1.0, 19.0)).to eq(0.05)
#     end
#   end 


#   describe '#Tackles' do
#     xit 'finds most number of tackles' do
#       expect(@game_stats.most_tackles).to eq(95)
#     end

#     xit 'finds least number of tackles' do
#       expect(@game_stats.least_tackles).to eq()
#     end
#   end

#   describe "#average_goals_per_game" do
#     it 'will find the average goals' do
#       #this test is for the fixture
#       expect(@game_stats.average_goals_per_game).to eq(3.67)
#       #this test is for the full data
#       # expect(@game_stats.average_goals_per_game).to eq(4.22)
#     end
#   end

#   describe "#team_goals" do 
#     it 'will find the amount of goals per team' do
#       expect(@game_stats.team_goals("home")).to be_instance_of(Hash)
#       #this test is for the fixture
#       expect(@game_stats.team_goals("away")).to eq({"3"=>5, "6"=>12, "5"=>1, "17"=>3, "16"=>1})
#       expect(@game_stats.team_goals("home")).to eq({"3"=>3, "6"=>12, "5"=>1, "17"=>3, "16"=>3})

#     end
#   end
#   describe "#games_by_team" do 
#     it 'will find the amount of home games per team' do
#       expect(@game_stats.games_by_team("home")).to be_instance_of(Hash)
#       #this test is for the fixture
#       expect(@game_stats.games_by_team("home")).to eq({"3"=>2, "6"=>5, "5"=>2, "17"=>1, "16"=>2})
#     end

#     it 'will find the amount of away games per team' do
#       expect(@game_stats.games_by_team("away")).to be_instance_of(Hash)
#       #this test is for the fixture
#       expect(@game_stats.games_by_team("away")).to eq({"3"=>3, "6"=>4, "5"=>2, "17"=>2, "16"=>1})
#     end
#   end

#   describe "#highest_scoring_visitor" do
#     it 'finds team with highest average score when away' do
#     #this test is for the fixture
#     expect(@game_stats.highest_scoring_visitor).to eq("FC Dallas")
#   end
# end
#   describe "#lowest_scoring_visitor" do
#     xit 'finds team with lowest average score when away' do
#   #this test is for the fixture
#   expect(@game_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
# end
# end
# describe "#highest_scoring_home_team" do
# xit 'finds team with highest average score when away' do
#   #this test is for the fixture
#       expect(@game_stats.highest_scoring_home_team).to eq("LA Galaxy")
#     end
#   end
#   describe "#lowest_scoring_home_team" do
#     xit 'finds team with lowest average score when away' do
#       expect(@game_stats.lowest_scoring_home_team).to eq("Sporting Kansas City")
#     end
#   end
# end

it "exists" do
  expect(@stat_tracker).to be_an_instance_of StatTracker
end

it "#highest_total_score" do
  expect(@stat_tracker.highest_total_score).to eq 11
end

it "#lowest_total_score" do
  expect(@stat_tracker.lowest_total_score).to eq 0
end

it "#percentage_home_wins" do
  expect(@stat_tracker.percentage_home_wins).to eq 0.44
end

#   it "#percentage_visitor_wins" do
#     expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
#   end

#   it "#percentage_ties" do
#     expect(@stat_tracker.percentage_ties).to eq 0.20
#   end

#   it "#count_of_games_by_season" do
#     expected = {
#       "20122013"=>806,
#       "20162017"=>1317,
#       "20142015"=>1319,
#       "20152016"=>1321,
#       "20132014"=>1323,
#       "20172018"=>1355
#     }
#     expect(@stat_tracker.count_of_games_by_season).to eq expected
#   end

#   it "#average_goals_per_game" do
#     expect(@stat_tracker.average_goals_per_game).to eq 4.22
#   end

#   it "#average_goals_by_season" do
#     expected = {
#       "20122013"=>4.12,
#       "20162017"=>4.23,
#       "20142015"=>4.14,
#       "20152016"=>4.16,
#       "20132014"=>4.19,
#       "20172018"=>4.44
#     }
#     expect(@stat_tracker.average_goals_by_season).to eq expected
#   end

#   it "#count_of_teams" do
#     expect(@stat_tracker.count_of_teams).to eq 32
#   end

#   it "#best_offense" do
#     expect(@stat_tracker.best_offense).to eq "Reign FC"
#   end

#   it "#worst_offense" do
#     expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
#   end

#   it "#highest_scoring_visitor" do
#     expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
#   end

#   it "#highest_scoring_home_team" do
#     expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
#   end

#   it "#lowest_scoring_visitor" do
#     expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
#   end

#   it "#lowest_scoring_home_team" do
#     expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
#   end

#   it "#team_info" do
#     expected = {
#       "team_id" => "18",
#       "franchise_id" => "34",
#       "team_name" => "Minnesota United FC",
#       "abbreviation" => "MIN",
#       "link" => "/api/v1/teams/18"
#     }

#     expect(@stat_tracker.team_info("18")).to eq expected
#   end

#   it "#best_season" do
#     expect(@stat_tracker.best_season("6")).to eq "20132014"
#   end

#   it "#worst_season" do
#     expect(@stat_tracker.worst_season("6")).to eq "20142015"
#   end

#   it "#average_win_percentage" do
#     expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
#   end

#   it "#most_goals_scored" do
#     expect(@stat_tracker.most_goals_scored("18")).to eq 7
#   end

#   it "#fewest_goals_scored" do
#     expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
#   end

#   it "#favorite_opponent" do
#     expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
#   end

#   it "#rival" do
#     expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
#   end

#   it "#winningest_coach" do
#     expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
#     expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
#   end

#   it "#worst_coach" do
#     expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
#     expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
#   end

#   it "#most_accurate_team" do
#     expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
#     expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
#   end

#   it "#least_accurate_team" do
#     expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
#     expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
#   end

#   it "#most_tackles" do
#     expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
#     expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
#   end

#   it "#fewest_tackles" do
#     expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
#     expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
#   end
end

#   describe "#percent ties" do
#     it "finds percntage of tied away and home games" do
#       expect(@game_stats.percentage_ties).to eq(0.05)
#     end
#   end

#   describe "#percentage_calculator" do
#     it "finds the percentage for given numbers rounded to nearest 100th" do
#       expect( .percentage_calculator(13.0, 19.0)).to eq(0.68)
#       expect(@game_stats.percentage_calculator(5.0, 19.0)).to eq(0.26)
#       expect(@game_stats.percentage_calculator(1.0, 19.0)).to eq(0.05)
#     end
#   end 


#   describe '#Tackles' do
#     xit 'finds most number of tackles' do
#       expect(@game_stats.most_tackles).to eq(95)
#     end

#     xit 'finds least number of tackles' do
#       expect(@game_stats.least_tackles).to eq()
#     end
#   end

#   describe "#average_goals_per_game" do
#     it 'will find the average goals' do
#       #this test is for the fixture
#       expect(@game_stats.average_goals_per_game).to eq(3.67)
#       #this test is for the full data
#       # expect(@game_stats.average_goals_per_game).to eq(4.22)
#     end
#   end

#   describe "#team_goals" do 
#     it 'will find the amount of goals per team' do
#       expect(@game_stats.team_goals("home")).to be_instance_of(Hash)
#       #this test is for the fixture
#       expect(@game_stats.team_goals("away")).to eq({"3"=>5, "6"=>12, "5"=>1, "17"=>3, "16"=>1})
#       expect(@game_stats.team_goals("home")).to eq({"3"=>3, "6"=>12, "5"=>1, "17"=>3, "16"=>3})

#     end
#   end
#   describe "#games_by_team" do 
#     it 'will find the amount of home games per team' do
#       expect(@game_stats.games_by_team("home")).to be_instance_of(Hash)
#       #this test is for the fixture
#       expect(@game_stats.games_by_team("home")).to eq({"3"=>2, "6"=>5, "5"=>2, "17"=>1, "16"=>2})
#     end

#     it 'will find the amount of away games per team' do
#       expect(@game_stats.games_by_team("away")).to be_instance_of(Hash)
#       #this test is for the fixture
#       expect(@game_stats.games_by_team("away")).to eq({"3"=>3, "6"=>4, "5"=>2, "17"=>2, "16"=>1})
#     end
#   end

#   describe "#highest_scoring_visitor" do
#     it 'finds team with highest average score when away' do
#     #this test is for the fixture
#     expect(@game_stats.highest_scoring_visitor).to eq("FC Dallas")
#   end
# end
#   describe "#lowest_scoring_visitor" do
#     xit 'finds team with lowest average score when away' do
#   #this test is for the fixture
#   expect(@game_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
# end
# end
# describe "#highest_scoring_home_team" do
# xit 'finds team with highest average score when away' do
#   #this test is for the fixture
#       expect(@game_stats.highest_scoring_home_team).to eq("LA Galaxy")
#     end
#   end
#   describe "#lowest_scoring_home_team" do
#     xit 'finds team with lowest average score when away' do
#       expect(@game_stats.lowest_scoring_home_team).to eq("Sporting Kansas City")
#     end
#   end
# end
