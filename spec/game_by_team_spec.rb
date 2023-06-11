require 'spec_helper'

RSpec.describe GameTeam do
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

    @game_teams = GameTeam.new(@data)
  end

  describe "#exists" do
    it "#exists" do
      expect(@game_teams).to be_a(GameTeam)
    end

    it "has readable attributes" do
      expect(@game_teams.game_id).to eq(2012030221)
      expect(@game_teams.team_id).to eq(3)
      expect(@game_teams.hoa).to eq("away")
      expect(@game_teams.result).to eq("LOSS")
      expect(@game_teams.settled_in).to eq("OT")
      expect(@game_teams.head_coach).to eq("John Tortorella")
      expect(@game_teams.goals).to eq(2)
      expect(@game_teams.shots).to eq(8)
      expect(@game_teams.tackles).to eq(44)
    end

  end
end