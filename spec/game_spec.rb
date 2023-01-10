require_relative "./spec_helper"

RSpec.describe Game do
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
        @game = Game.new(info)
    end

    describe "#initialize" do
        it "exists" do
            expect(@game).to be_instance_of Game
        end

        it "has attributes" do
            expect(@game.game_id).to eq('2012030314')
            expect(@game.season).to eq('20122013')
            expect(@game.type).to eq('Postseason')
            expect(@game.date_time).to eq('6/8/13')
            expect(@game.away_team_id).to eq('5')
            expect(@game.home_team_id).to eq('6')
            expect(@game.away_goals).to eq(0)
            expect(@game.home_goals).to eq(1)
            expect(@game.venue).to eq('Toyota Stadium')
            expect(@game.venue_link).to eq('/api/v1/venues/null')
        end
    end

    describe "helpers" do
        it " has game total scores" do 
            expect(@game.game_total_score).to eq 1
        end

        it "#home_wins" do
            expect(@game.home_wins).to eq(1)
        end

        it "#visitor_wins" do
            expect(@game.visitor_wins).to eq(0)
        end
    end
end

