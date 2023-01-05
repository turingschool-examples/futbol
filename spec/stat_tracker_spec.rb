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
    
    describe "#initialize" do
        it "exists" do
            expect(@stat_tracker).to be_instance_of(StatTracker)
        end
    end

    describe "#total_score" do
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
    
    describe "#percentages" do
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
end