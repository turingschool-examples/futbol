require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe GameTeams do
  describe '#initialize' do
    it "exists with attributes" do
      game_teams = GameTeams.new("012030221", 3, :away, :LOSS, :OT, "John Tortorella", 2, 8, 44, 8, 3, 0, 44.8, 17, 7)
      
      expect(game_teams).to be_a GameTeams
      expect(game_teams.game_id).to eq("012030221")
      expect(game_teams.team_id).to eq(3)
      expect(game_teams.hoa).to eq(:away)
      expect(game_teams.result).to eq(:LOSS)
      expect(game_teams.settled_in).to eq(:OT)
      expect(game_teams.head_coach).to eq("John Tortorella")
      expect(game_teams.goals).to eq 2
      expect(game_teams.shots).to eq 8
      expect(game_teams.tackles).to eq 44
      expect(game_teams.pim).to eq 8
      expect(game_teams.power_play_opportunities).to eq 3
      expect(game_teams.power_play_goals).to eq 0
      expect(game_teams.face_off_win_percentage).to eq 44.8
      expect(game_teams.give_aways).to eq 17
      expect(game_teams.take_aways).to eq 7
    end

    it 'can create data objects from csv file' do
      path = "./data/test_game_teams.csv"
      game_teams = GameTeams.create_game_teams_data_objects(path)

      expect(game_teams.count).to be 19
      expect(game_teams).to be_all GameTeams

      expect(game_teams[0]).to be_a GameTeams
      expect(game_teams[0].game_id).to eq("2012030221")
      expect(game_teams[0].team_id).to eq 3
      expect(game_teams[0].hoa).to eq(:away)
      expect(game_teams[0].result).to eq(:LOSS)
      expect(game_teams[0].settled_in).to eq(:OT)
      expect(game_teams[0].head_coach).to eq("John Tortorella")
      expect(game_teams[0].goals).to eq 2
      expect(game_teams[0].shots).to eq 8
      expect(game_teams[0].tackles).to eq 44
      expect(game_teams[0].pim).to eq 8
      expect(game_teams[0].power_play_opportunities).to eq 3
      expect(game_teams[0].power_play_goals).to eq 0
      expect(game_teams[0].face_off_win_percentage).to eq 44.8
      expect(game_teams[0].give_aways).to eq 17
      expect(game_teams[0].take_aways).to eq 7
    end
  end

end