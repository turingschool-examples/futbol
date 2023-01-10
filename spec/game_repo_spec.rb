require_relative "./spec_helper"

RSpec.describe GameRepo do
    before do
        info = {
            game_id: '2012030314',
            season: '20122013',
            type: 'Postseason',
            date_time: '6/8/13',
            away_team_id: '5',
            home_team_id: '6',
            away_goals: 0,
            home_goals: 1,
            venue: 'Toyota Stadium',
            venue_link: '/api/v1/venues/null'
        }
        @game = GameRepo.new(info)
    end


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