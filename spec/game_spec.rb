require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new("2012030221", "20122013", "Postseason", "3", "6", "2", "3", "Toyota Stadium")
  end

  describe 'initialize' do
    it 'exits' do
      expect(@game).to be_a(Game)
    end

    it "has readable attributes" do
      expect(@game.id).to eq("2012030221")
    end
  end
end