require_relative 'spec_helper'

RSpec.describe Team do
  let(:team) { Team.new(info) }
  let(:info) do
    { 
      team_id: "1",
      franchise_id: "1",
      team_name: "teamname",
      abbreviation: "ABC",
      stadium: "Stadium name",
      link: "link"
    }
  end
  describe "#initialize" do

    it 'exists' do
      expect(team).to be_an_instance_of(Team)
    end

    it 'has readable attributes' do
      expect(team.team_id).to eq("1")
      expect(team.franchise_id).to eq("1")
      expect(team.team_name).to eq("teamname")
      expect(team.abbreviation).to eq("ABC")
      expect(team.stadium).to eq("Stadium name")
      expect(team.link).to eq("link")
    end
  end
end
