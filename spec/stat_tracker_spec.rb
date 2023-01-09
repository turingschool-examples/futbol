require_relative "spec_helper"

RSpec.describe StatTracker do
    before do 
        @game_path = './spec/fixtures/games.csv'
        @team_path = './spec/fixtures/teams.csv'
        @game_teams_path = './spec/fixtures/game_teams.csv'

        location_paths = {
            games: @game_path,
            teams: @team_path,
            game_teams: @game_teams_path
          }

        @stat_tracker = StatTracker.from_csv(location_paths)
    end
    
    describe "#Initialize" do
        it "exists" do
            expect(@stat_tracker).to be_instance_of(StatTracker)
        end
    end

    describe "#Total_score" do
        it " has game total scores" do 
            expect(@stat_tracker.games_total_score_array).to eq [1, 4, 5, 3, 6, 4, 1, 4, 2, 5]
        end

        it "#highest_total_score" do
            expect(@stat_tracker.highest_total_score).to eq 6
        end 
        
        it "#lowest_total_score" do
            expect(@stat_tracker.lowest_total_score).to eq 1
        end 
    end
    
    describe "#Percentages" do
        it "#percentage_home_wins" do
            expect(@stat_tracker.percentage_home_wins).to eq 0.50
        end
        
        it "#percentage_visitor_wins" do
            expect(@stat_tracker.percentage_visitor_wins).to eq 0.2
        end
        
        it "#percentage_ties" do
            expect(@stat_tracker.percentage_ties).to eq 0.3
        end
    end

    describe "#Game count and averages" do
        it "#count_of_games_by_season" do
        expected = {
            "20122013"=>1,
            "20132014"=>1,
            "20142015"=>2,
            "20152016"=>2,
            "20162017"=>2,
            "20172018"=>2
          }
          expect(@stat_tracker.count_of_games_by_season).to eq expected
        end

        it "#average_goals_per_game" do
        expect(@stat_tracker.average_goals_per_game).to eq 3.5
      end

        it "#average_goals_by_season" do
        expected = {
            "20122013"=>1.0,
            "20132014"=>3.0,
            "20142015"=>5.5,
            "20152016"=>3.0,
            "20162017"=>4.0,
            "20172018"=>3.0
        }
        expect(@stat_tracker.average_goals_by_season).to eq expected
       end
    end

    describe "Teams, best, and worst offense" do 
        it "#count of teams" do 
            expect(@stat_tracker.count_of_teams).to eq 17
        end

        it "#best_offense" do 
            expect(@stat_tracker.best_offense).to eq "New England Revolution"
        end

        it "#worst_offense" do
            expect(@stat_tracker.worst_offense).to eq "Sporting Kansas City"
        end
    end
   
    describe "#Highest/lowest scoring home/away" do
        it "#highest_scoring_visitor" do
        expect(@stat_tracker.highest_scoring_visitor).to eq "Columbus Crew SC"
        end

        it "#highest_scoring_home_team" do
        expect(@stat_tracker.highest_scoring_home_team).to eq "Minnesota United FC"
        end

        it "#lowest_scoring_visitor" do
        expect(@stat_tracker.lowest_scoring_visitor).to eq "Sporting Kansas City"
        end

        it "#lowest_scoring_home_team" do
        expect(@stat_tracker.lowest_scoring_home_team).to eq "FC Dallas"
      end
    end

    describe "#Team_statistics" do
        it "#team_info" do
            expected = {
            "team_id" => "18",
            "franchise_id" => "34",
            "team_name" => "Minnesota United FC",
            "abbreviation" => "MIN",
            "link" => "/api/v1/teams/18"
            }
        
            expect(@stat_tracker.team_info("18")).to eq expected
        end

        it "#best_season" do
            expect(@stat_tracker.best_season("6")).to eq "20122013"
        end

        it "#worst_season" do
            expect(@stat_tracker.worst_season("6")).to eq "20122013"
        end
    end

    describe "#Teams avg win, most and fewest goals" do
        it "#average_win_percentage" do
            expect(@stat_tracker.average_win_percentage("18")).to eq 0.50
        end

        it '#most_goals_scored' do
        expect(@stat_tracker.most_goals_scored("52")).to eq(2)
        end

        it '#fewest_goals_scored' do
        expect(@stat_tracker.fewest_goals_scored("52")).to eq(1)
        end
    end

    describe "#Favorite opponent and rival" do
        it "#favorite_opponent" do
            expect(@stat_tracker.favorite_opponent("18")).to eq "Real Salt Lake"
        end

        it "#rival" do
            expect(@stat_tracker.rival("18")).to eq("New England Revolution")
        end
    end

    describe "#Winningest and worst coach" do
        it "#winningest_coach" do
            expect(@stat_tracker.winningest_coach("20132014")).to eq "Alain Vigneault"
            expect(@stat_tracker.winningest_coach("20142015")).to eq "Joel Quenneville"
        end

        it "#worst_coach" do
            expect(@stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette").or(eq("Craig Berube"))
            expect(@stat_tracker.worst_coach("20142015")).to eq("Craig Berube").or(eq("Peter Laviolette"))
        end
    end

    describe "#Team accuracy" do
        it "#most_accurate_team" do
            expect(@stat_tracker.most_accurate_team("20132014")).to eq "Houston Dynamo"
            expect(@stat_tracker.most_accurate_team("20142015")).to eq "Columbus Crew SC"
        end

        it "#least_accurate_team" do
            expect(@stat_tracker.least_accurate_team("20132014")).to eq "Chicago Fire"
            expect(@stat_tracker.least_accurate_team("20142015")).to eq("Columbus Crew SC").or(eq("Minnesota United FC"))
        end
    end

    describe "#Most, fewest tackles" do
        it "#most_tackles" do
            expect(@stat_tracker.most_tackles("20132014")).to eq "Houston Dynamo"
            expect(@stat_tracker.most_tackles("20142015")).to eq("Seattle Sounders FC").or(eq("Minnesota United FC"))
        end
        
        it "#fewest_tackles" do
            expect(@stat_tracker.fewest_tackles("20132014")).to eq "Houston Dynamo"
            expect(@stat_tracker.fewest_tackles("20142015")).to eq("Orlando City SC").or(eq("Columbus Crew SC"))
        end
    end 
end
