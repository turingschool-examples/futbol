require 'spec_helper'

RSpec.describe Game_By_Team do
  before do
    @data = {
    :game_id      => 2012030221,
    :team_id      => 3,
    :hoa          => "away",
    :result       => "LOSS",
    :settled_in   => "OT",
    :head_coach   => "John Tortorella",
    :goals        => 2,
    :shots        => 8,
    :tackles      => 44
    }
    
    @game_by_team = Game_By_Team.new(@data)
  end

  describe "#exists" do
    it "#exists" do
      expect(@game_by_team).to be_a(Game_By_Team)
    end

    it "has readable attributes" do
      expect(@game_by_team.game_id).to eq(2012030221)
      expect(@game_by_team.team_id).to eq(3)
      expect(@game_by_team.hoa).to eq("away")
      expect(@game_by_team.result).to eq("LOSS")
      expect(@game_by_team.settled_in).to eq("OT")
      expect(@game_by_team.head_coach).to eq("John Tortorella")
      expect(@game_by_team.goals).to eq(2)
      expect(@game_by_team.shots).to eq(8)
      expect(@game_by_team.tackles).to eq(44)
    end

  end
end