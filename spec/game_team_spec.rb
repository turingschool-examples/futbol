require_relative 'spec_helper'

describe GameTeam do
  let (gameteam1) {gameteam1 = Game.new({ game_id: 123456, 
                                          hoa: "home",
                                          team_id: 7337,
                                          results: "WIN",
                                          coach: "Hank Hill",
                                          goals: 2 }, 
                                          [{teamname: "chinchillas", team_id: 7337},
                                          {teamname: "sloths", team_id: 4008}])}

  describe "set-up" do
    it "exists" do
      expect(gameteam1).to be_a GameTeam
    end
    it "has attributes" do
      expect(gameteam1.game_id).to eq(123456)
      expect(gameteam1.team_id).to eq(7337)
      expect(gameteam1.home).to be true
      expect(gameteam1.result).to eq("WIN")
      expect(gameteam1.coach).to eq("Hank Hill")
      expect(gameteam1.teamname).to eq("chinchillas")
    end
  end
end
