require_relative "./spec_helper"

RSpec.describe Game do
    before do
        info = {
            'game_id' => '2012030314',
            'season' => '20122013',
            'type' => 'Postseason',
            'date_time' => '6/8/13',
            'away_team_id' => '5',
            'home_team_id' => '6',
            'away_goals' => 0,
            'home_goals' => 1,
            'venue' => 'Toyota Stadium',
            'venue_link' => '/api/v1/venues/null'
        }
        @game = Game.new(info)
    end

    describe "#initialize" do
        it "exists" do
            expect(@game).to be_instance_of Game
        end

        it "has attributes" do
            
        end
    end
end

