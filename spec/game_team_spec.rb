require './spec/spec_helper'

describe GameTeam do
    before :each do
        @game_team = GameTeam.new(2012030221,3,"away","LOSS","OT","John Tortorella",2,8,44,8,3,0,44.8,17,7)
    end

    describe '#intialize' do
        it 'exists' do
            expect(@game_team).to be_a GameTeam
        end
    end
end