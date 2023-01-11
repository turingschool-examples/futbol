require_relative "./spec_helper"

RSpec.describe GameRepo do
    before(:each) do
        @game_path = './spec/fixtures/games.csv'
        @team_path = './spec/fixtures/teams.csv'
        @game_teams_path = './spec/fixtures/game_teams.csv'
    
        locations = {
          games: @game_path,
          teams: @team_path,
          game_teams: @game_teams_path
        }
        
        @game = GameRepo.new(locations)
    end

    describe "#Initialize" do
        it "exists" do
            expect(@game).to be_instance_of(GameRepo)
        end
    end

    describe "helpers" do
        it " has game total scores" do 
            expect(@game.game_total_score).to eq([1, 4, 5, 3, 6, 4, 1, 4, 2, 5])
        end

        it "#home_wins" do
            expect(@game.home_wins).to eq(5)
        end

        it "#visitor_wins" do
            expect(@game.visitor_wins).to eq(2)
        end

        it "#game_ties" do
            expect(@game.game_ties).to eq(3)
        end
    end

    describe "#Total_score" do
        it "#highest_total_score" do
            expect(@game.highest_total_score).to eq 6
        end 
        
        it "#lowest_total_score" do
            expect(@game.lowest_total_score).to eq 1
        end 
    end

    describe "#Percentages" do
        it "#percentage_home_wins" do
            expect(@game.percentage_home_wins).to eq 0.50
        end
        
        it "#percentage_visitor_wins" do
            expect(@game.percentage_visitor_wins).to eq 0.2
        end
        
        it "#percentage_ties" do
            expect(@game.percentage_ties).to eq 0.3
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
          expect(@game.count_of_games_by_season).to eq expected
        end

        it "#average_goals_per_game" do
        expect(@game.average_goals_per_game).to eq 3.5
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
        expect(@game.average_goals_by_season).to eq expected
       end
    end
end