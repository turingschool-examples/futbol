require './lib/team'

RSpec.describe Team do
  before do
    info = {
      team_id: "1",
      franchiseid: "23",
      teamname: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes_Benz Stadium",
      link: "api/v1/teams/1"
    }
    @team = Team.new(info)
  end

  describe '#initialize' do
    it 'exists' do

      expect(@team).to be_instance_of(Team)
    end
  end

  describe '@attributes' do
    it 'has a team id' do

      expect(@team.team_id).to eq("1")
    end

    it 'has a franchise id' do

      expect(@team.franchise_id).to eq("23")
    end

    it 'has a team name' do

      expect(@team.team_name).to eq("Atlanta United")
    end

    it 'has an abbreviation' do

      expect(@team.abbreviation).to eq("ATL")
    end

    it 'has a stadium' do

      expect(@team.stadium).to eq("Mercedes_Benz Stadium")
    end

    it 'has a link' do

      expect(@team.link).to eq("api/v1/teams/1")
    end
  end
end
