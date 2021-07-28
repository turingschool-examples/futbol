require './lib/game_teams'

RSpec.describe GameTeam do
  context "it's a futbol game teams class" do
    game = GameTeam.new({game_id: "2012030222",
    team_id: "3",
    home_or_away: "away",
    result: "LOSS",
    head_coach: "John Tortorella",
    goals: "2",
    shots: "9",
    tackles: "33"})

    it "exists" do
      expect(game).to be_a(GameTeam)
    end

    it "has attributes" do
      expect(game.team_id).to eq("3")
    end
  end
end
