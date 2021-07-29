require './lib/team_manager'

RSpec.describe TeamManager do
  describe '#load' do
    it 'length' do
      file_path = './data/teams.csv'
      team_manager = TeamManager.new(file_path)

      expect(team_manager.load.length).to eq(32)
    end

    it 'creates game object for every row' do
      file_path = './data/teams.csv'
      team_manager = TeamManager.new(file_path)
      team_manager.load

      team_manager.teams.each do |team_id, team_object|
        expect(team_object).to be_instance_of(Team)
      end
    end
  end
end
