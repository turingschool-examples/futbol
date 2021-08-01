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

    it 'creates a team object for every row' do
      expect(@team_manager.teams.first).to be_instance_of(Team)
    end
  end

  describe '#count_of_teams' do
    it '#count_of_teams' do
      expect(@team_manager.count_of_teams).to eq(32)
    end
  end

  describe '#team_by_id(team_id)' do
    it 'returns team  by id' do
      expect(@team_manager.team_by_id("1").teamname).to eq("Atlanta United")
    end
  end

  describe '#team_name_by_id(team_id)' do
    it 'gets team name  by id' do
      expect(@team_manager.team_name_by_id("1")).to eq("Atlanta United")
    end
  end


  describe '#team_info(team_id)' do
    it 'returns a hash of attributes per team_id' do
      expected = {
        "team_id"      => "1",
        "franchise_id"  => "23",
        "team_name"     => "Atlanta United",
        "abbreviation" => "ATL",
        "link"         => "/api/v1/teams/1"
      }

      expect(@team_manager.team_info("1")).to eq (expected)
    end
  end
end
