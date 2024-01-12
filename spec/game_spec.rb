require './spec/spec_helper'

RSpec.describe Game do
    before(:each) do
        @game = Game.new(
           2012030221,
           20122013,
           "Postseason",
            5/16/13,
            3,
            6,
            2,
            3,
            "Toyota Stadium"
        )
    end


    it 'exits' do
        expect(@game).to be_an_instance_of(Game)
    end


end
