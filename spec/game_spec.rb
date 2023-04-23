require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new({
      game_id: "2012030221",
      season: "20122013",
      type: "Postseason",
      away_team_id: "3",
      home_team_id: "6",
      away_goals: "2",
      home_goals: "3",
      venue: "Toyota Stadium"
    })
  end

  describe 'initialize' do
    it 'exits' do
      expect(@game).to be_a(Game)
    end

    it "has readable attributes" do
      expect(@game.id).to eq("2012030221")
      expect(@game.season).to eq("20122013")
      expect(@game.type).to eq("Postseason")
      expect(@game.away_team_id).to eq("3")
      expect(@game.home_team_id).to eq("6")
      expect(@game.away_goals).to eq(2)
      expect(@game.home_goals).to eq(3)
      expect(@game.venue).to eq("Toyota Stadium")
    end
  end
end