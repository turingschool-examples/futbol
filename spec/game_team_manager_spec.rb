require './lib/game_team_manager'

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

      game_team_manager.game_teams.each do |game_id, team_array|
        expect(team_array[0]).to be_instance_of(GameTeam)
        expect(team_array[1]).to be_instance_of(GameTeam)
      end
    end
  end
end
