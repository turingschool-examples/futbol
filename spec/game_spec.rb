require 'spec_helper'

RSpec.describe Game do
   it 'exists' do
      game = Game.new(2012030221, 20122013, 3, 6, 2, 3)

      expect(game).to be_a Game
   end
end