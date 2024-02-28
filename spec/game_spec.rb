require './spec/spec_helper'

RSpec.describe Game do
      before(:each) do
        @game1 = Game.new(2012030221, 20122013, "Postseason", 3, 6, 2, 3)
      end

        it 'exists' do
          expect(@game1).to be_an_instance_of Game
        end
      
        it 'has attributes' do
          expect(@game1.game_id).to eq 2012030221
          expect(@game1.season).to eq 20122013
          expect(@game1.type).to eq "Postseason"
          expect(@game1.away_team_id).to eq 3
          expect(@game1.home_team_id).to eq 6
          expect(@game1.away_goals).to eq 2
          expect(@game1.home_goals).to eq 3
        end
      
    

end