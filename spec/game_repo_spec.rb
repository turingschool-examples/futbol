require_relative "./spec_helper"

RSpec.describe GameRepo do
    before(:each) do
        game_path = './data/games_sample.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams_sample.csv'
    
        locations = {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
        }
    end

    @game = GameRepo.new(game_path)

    describe "helpers" do
        it " has game total scores" do 
            expect(@game.game_total_score).to eq 1
        end

        xit "#home_wins" do
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