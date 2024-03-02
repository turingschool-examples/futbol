require 'spec_helper'

RSpec.describe Team do
  before(:all) do
    @teams = Team.create_from_csv("./data/teams.csv")
  end
  describe '#initialize' do
    before(:each) do
      team_data = {
        id: 1,
        name: "Atlanta United"
      }
      @team1 = Team.new(team_data)
    end  

    xit 'exists' do
      expect(@team1).to be_an_instance_of Team
    end

    xit 'has attributes that can be read' do
      expect(@team1.id).to eq 1
      expect(@team1.name).to eq "Atlanta United"
    end
  end

  xit "can create Team objects using the create_from_csv method" do
    
    starter = @teams.first
    expect(starter.id).to eq 1
    expect(starter.name).to eq "Atlanta United"
  end

  it 'has the team name and id' do
    expect(Team.find_team_name_by_id(6)).to eq("FC Dallas")
  end
end