require 'spec_helper'
RSpec.describe Game do
  before(:each) do
    @game = Game.new('2012030221', '20122013', 'Postseason', '5/16/13', '3', '6', 2, 3, 'Toyota Stadium')
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@game).to be_a Game
    end

    it 'has attributes' do 
      expect(@game.game_id).to eq('2012030221')
      expect(@game.season).to eq('20122013')
      expect(@game.type).to eq('Postseason')
      expect(@game.date_time).to eq('5/16/13')
      expect(@game.away_team_id).to eq('3')
      expect(@game.home_team_id).to eq('6')
      expect(@game.away_goals).to eq(2)
      expect(@game.home_goals).to eq(3)
      expect(@game.venue).to eq('Toyota Stadium')
    end
  end
end