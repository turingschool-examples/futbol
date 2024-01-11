require 'spec_helper'
require 'simplecov'

RSpec.describe Game do
   before(:each) do
      @game_details = {
         game_id: 2012030221,
         season: 20122013,
         away_team_id: 3,
         home_team_id: 6,
         away_goals: 2,
         home_goals: 3
      }
   end

   describe '#initialize' do
      it 'exists' do
         game = Game.new(@game_details)

         expect(game).to be_a Game
      end

      it 'has attributes' do
         game = Game.new(@game_details)

         expect(game.game_id).to eq(2012030221)
         expect(game.season).to eq(20122013)
         expect(game.away_team_id).to eq(3)
         expect(game.home_team_id).to eq(6)
         expect(game.away_goals).to eq(2)
         expect(game.home_goals).to eq(3)
      end
   end
end