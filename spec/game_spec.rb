require 'spec_helper'

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

   it 'exists' do
      game = Game.new(@game_details)

      expect(game).to be_a Game
   end
end