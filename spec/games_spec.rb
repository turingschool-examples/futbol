require "spec_helper"

describe Games do
  before(:each) do
    @game1 = Games.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@game1).to be_a(Games)
      expect(@game1.game_id).to be 2012030221
      expect(@game1.season).to be 20122013
      expect(@game1.type).to eq("Postseason")
      expect(@game1.date_time).to eq("5/16/13")
      expect(@game1.away_team_id).to be 3
      expect(@game1.home_team_id).to be 6
      expect(@game1.away_goals).to be 2
      expect(@game1.home_goals).to be 3
      expect(@game1.venue).to eq("Toyota Stadium")
    end
  end
end