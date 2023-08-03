require 'spec_helper'
require './lib/game'

describe Team do 
  #will need to rename this class
  before(:each) do 
    @game1 = Game.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium")
  end

  describe '#initialize' do 
    it 'exists with attributes' do 
      expect(@game1).to be_a(Game)
      expect(@game1.game_id).to eq(2012030221)
      expect(@game1.season).to eq(20122013)
      expect(@game1.type).to eq("Postseason")
      expect(@game1.date_time).to eq("5/16/13")
      expect(@game1.away_team_id).to eq(3)
      expect(@game1.home_team_id).to eq(6)
      expect(@game1.away_goals).to eq(2)
      expect(@game1.home_goals).to eq(3)
      expect(@game1.venue).to eq("Toyota Stadium")
    end
  end
end