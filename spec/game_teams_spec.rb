require 'spec_helper'

RSpec.describe GameTeams do 
  let(:game_teams_data) { CSV.readlines('./data/test_game_teams.csv', headers: true, header_converters: :symbol) } 
  let(:game_teams) { GameTeams.new(game_teams_data.first) } 
  
  describe '#initialize' do 
    it 'exists' do 
      expect(game_teams).to be_a(GameTeams)
      expect(game_teams.game_id).to eq(2012030221)
      expect(game_teams.team_id).to eq(3)
      expect(game_teams.hoa).to eq("away")
      expect(game_teams.result).to eq("LOSS")
      expect(game_teams.settled_in).to eq("OT")
      expect(game_teams.head_coach).to eq("John Tortorella")
      expect(game_teams.goals).to eq(2)
      expect(game_teams.shots).to eq(8)
      expect(game_teams.tackles).to eq(44)
      expect(game_teams.pim).to eq(8)
      expect(game_teams.power_play_opportunity).to eq(3)
      expect(game_teams.power_play_goals).to eq(0)
      expect(game_teams.faceoff_win_percentage).to eq(44.8)
      expect(game_teams.giveaways).to eq(17)
      expect(game_teams.takeaway).to eq(7)
    end
  end
end 