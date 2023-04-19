require 'spec_helper'

RSpec.describe Game do
  before(:each) do
    @game = Game.new 
  end

  describe '#initialize' do 
    it 'exists' do
      expect(@game).to be_a Game
    end

    it 'has attributes' do 
      expect(@game.game_id)
    end
end