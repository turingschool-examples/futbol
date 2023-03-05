require_relative './spec_helper'

describe GameTeam do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @test_game_teams = @stat_tracker.game_teams[0]
  end

  describe '#initialize' do
    it 'exists' do
      expect(@test_game_teams).to be_a GameTeam
    end

    it 'has attributes' do
      expect(@test_game_teams.game_id).to eq("2012030221")
      expect(@test_game_teams.team_id).to eq("3")
      expect(@test_game_teams.hoa).to eq("away")
      expect(@test_game_teams.result).to eq("LOSS")
      expect(@test_game_teams.settled_in).to eq("OT")
      expect(@test_game_teams.head_coach).to eq("John Tortorella")
      expect(@test_game_teams.goals).to eq(2)
      expect(@test_game_teams.shots).to eq(8)
      expect(@test_game_teams.tackles).to eq(44)
      expect(@test_game_teams.pim).to eq(8)
      expect(@test_game_teams.power_play_opportunities).to eq(3)
      expect(@test_game_teams.power_play_goals).to eq(0)
      expect(@test_game_teams.face_off_win_percentage).to eq(44.8)
      expect(@test_game_teams.give_aways).to eq(17)
      expect(@test_game_teams.take_aways).to eq(7)
      expect(@test_game_teams.season).to eq('20122013')
      expect(@test_game_teams.team_name).to eq('Houston Dynamo')
    end
  end
end
