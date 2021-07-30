require './lib/team_manager'

RSpec.describe TeamManager do
  before(:each) do
    @file_path = './data/teams.csv'
    @team_manager = TeamManager.new(@file_path)
    @team_manager.load

  end
  describe '#load' do
    it 'length' do
      expect(@team_manager.load.length).to eq(32)
    end

    it 'creates game object for every row' do
      @team_manager.teams.each do |team_id, team_object|
        expect(team_object).to be_instance_of(Team)
      end
    end
  end

  describe '#count_of_teams' do
    it '#count_of_teams' do
      expect(@team_manager.count_of_teams).to eq(32)
    end
  end
end
