require './spec/spec_helper'


describe Game do
    before :each do
        @game = Game.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium", "/api/v1/venues/null")
    end

    describe '#Initialize' do
        it 'exists' do
            expect(@game).to be_a Game
        end
    end
end