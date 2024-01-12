require './spec/spec_helper'

RSpec.describe Game do
    before(:each) do
        @        game = Game.new({
            :game_id => 2012030221, 
            :season => 20122013, 
            :type => "Postseason", 
            :date_time => 5/16/13, 
            :away_team_id => 3, 
            :home_team_id => 6, 
            :away_goals => 2, 
            :home_goals => 3, 
            :venue => "Toyota Stadium"
        })
    end
    
    end
    it 'exits' do
        expect(@game).to be_an_instance_of Game
    end 

    it 'calculates total score' do
        expect(@game.total_score).to eq(5)
    end
end 