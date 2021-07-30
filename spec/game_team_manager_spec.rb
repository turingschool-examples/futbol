require './lib/game_team_manager'

RSpec.describe GameTeamManager do
  describe '#load' do
    it 'length' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)

      expect(game_team_manager.load.length).to eq(78)
      expect(game_team_manager.game_teams.length).to eq(39)
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

  describe 'helper methods for best_offense and worse_offense' do
    file_path = './data/fixture_game_teams.csv'
    game_team_manager = GameTeamManager.new(file_path)
    game_team_manager.load

    it 'counts total games for all seasons' do
      expect(game_team_manager.total_games_all_seasons(3)).to eq(5)
    end
    it 'counts total goals for all seasons' do
      expect(game_team_manager.total_goals_all_seasons(3)).to eq(8)
    end
    it 'calculates average goals for all seasons' do
      expect(game_team_manager.average_goals_all_seasons(3)).to eq(1.60)
    end
  end

  describe 'best and worst offense methods' do
    file_path = './data/fixture_game_teams.csv'
    game_team_manager = GameTeamManager.new(file_path)
    game_team_manager.load

    it 'returns best_offense team_id' do
      expect(game_team_manager.best_offense).to eq(1)
    end

    it 'returns worst_offense team_id' do
      expect(game_team_manager.worst_offense).to eq(1)
    end
  end
end
