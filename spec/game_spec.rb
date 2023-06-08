require "spec_helper"

RSpec.describe Game do 
  describe "#initialize" do 
    it "exists w/ attributes" do
      game1 = Game.new("2012030221","20122013","Postseason","5/16/13","3","6","2","3","Toyota Stadium","/api/v1/venues/null")

      expect(game1).to be_instance_of(Game)
      expect(game1.game_id).to eq("2012030221")
      expect(game1.season).to eq("20122013")
      expect(game1.type).to eq("Postseason")
      expect(game1.date_time).to eq("5/16/13")
      expect(game1.away_team_id).to eq("3")
      expect(game1.home_team_id).to eq("6")
      expect(game1.away_goals).to eq("2")
      expect(game1.home_goals).to eq("3")
      expect(game1.venue).to eq("Toyota Stadium")
      expect(game1.venue_link).to eq("/api/v1/venues/null")
    end
  end
end