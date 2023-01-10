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
            expect(@game.home_wins).to eq(1)
        end

        xit "#visitor_wins" do
            expect(@game.visitor_wins).to eq(0)
        end

        xit "#game_ties" do
            expect(@game.game_ties).to eq(0)
        end
    end
end