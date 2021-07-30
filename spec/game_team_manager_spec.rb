require './lib/game_team_manager'
require './lib/stat_tracker'

RSpec.describe GameTeamManager do
  describe '#load' do
    it 'length' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)

      expect(game_team_manager.load.length).to eq(39)
      expect(game_team_manager.game_teams.length).to eq(20)
    end

    it 'creates game object for every row' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      game_team_manager.game_teams.each do |game_id, team_hash|
        expect(team_hash[:home]).to be_instance_of(GameTeam)
        expect(team_hash[:away]).to be_instance_of(GameTeam)
      end
    end
  end


end
