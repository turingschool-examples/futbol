require_relative 'spec_helper'

RSpec.describe GameTeam do
  let(:game_team) { GameTeam.new(info) }
  let(:info) do
    { 
      game_id: "1",
      team_id: "3",
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2",
      shots: "8",
      tackles: "44",
      pim: "8",
      power_play_opportunities: "3",
      power_play_goals: "0",
      faceoff_win_percentage: "44.8",
      give_aways: "17",
      take_aways: "7"
    }
  end
  describe "#initialize" do
    it 'exists' do
      expect(game_team).to be_instance_of(GameTeam)
    end

    it 'has readable attributes' do
      expect(game_team.game_id).to eq("1")
      expect(game_team.team_id).to eq("3")
      expect(game_team.hoa).to eq("away")
      expect(game_team.result).to eq("LOSS")
      expect(game_team.settled_in).to eq("OT")
      expect(game_team.head_coach).to eq("John Tortorella")
      expect(game_team.goals).to eq("2")
      expect(game_team.shots).to eq("8")
      expect(game_team.tackles).to eq("44")
      expect(game_team.pim).to eq("8")
      expect(game_team.power_play_opportunities).to eq("3")
      expect(game_team.power_play_goals).to eq("0")
      expect(game_team.faceoff_win_percentage).to eq("44.8")
      expect(game_team.give_aways).to eq("17")
      expect(game_team.take_aways).to eq("7")
    end
  end
end