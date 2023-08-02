require_relative 'spec_helper'

describe Game do
  describe "set-up" do
    let (:game1) {game1 = Game.new({ game_id: 123456, 
                                    season: 20202021,
                                    away_team_id: 7337,
                                    away_team_goals: 100,
                                    home_team_id: 4008,
                                    home_team_goals: 2 })}

    it "exists" do
      expect(game1).to be_a Game
    end

    it "has attribures" do
      expect(game1.game_id).to eq(123456)
      expect(game1.season).to eq(20202021)
      expect(game1.away_team_id).to eq(7337)
      expect(game1.away_team_goals).to eq(100)
      expect(game1.home_team_id).to eq(4008)
      expect(game1.home_team_goals).to eq(2)
    end
  end
end

