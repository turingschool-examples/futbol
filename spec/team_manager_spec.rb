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

  describe '#teams_by_id' do
    it 'creates teams_by_id hash' do
      expect(@team_manager.teams_by_id).to be_instance_of(Hash)
      expect(@team_manager.teams_by_id["1"]).to eq("Atlanta United")
    end
  end

  describe '#team_info(team_id)' do
    it 'returns a hash of attributes per team_id' do
      expected = {
        "team_id"      => "1",
        "franchiseId"  => "23",
        "teamName"     => "Atlanta United",
        "abbreviation" => "ATL",
        "link"         => "/api/v1/teams/1"
      }

      expect(@team_manager.team_info("1")).to eq (expected)
    end
  end
end
