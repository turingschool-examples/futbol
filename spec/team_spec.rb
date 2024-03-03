require 'spec_helper'

RSpec.describe Team do
  before(:all) do
    @teams = Team.create_from_csv("./data/teams.csv")
  end

  before(:each) do
    team_data = {
      id: 1,
      name: "Atlanta United"
    }
    @team1 = Team.new(team_data)
  end

  it 'exists' do
    expect(@team1).to be_an_instance_of Team
  end

  it 'has attributes that can be read' do
    expect(@team1.id).to eq "1"
    expect(@team1.name).to eq "Atlanta United"
  end

  it 'can create Team objects using the create_from_csv method' do
    expect(@teams.first.id).to eq "1"
    expect(@teams.first.name).to eq "Atlanta United"
  end

  it 'can return the team name when given a team_id' do
    expect(Team.find_team_name_by_id("3")).to eq "Houston Dynamo"
    expect(Team.find_team_name_by_id("6")).to eq "FC Dallas"
  end

  it "can count the total number of teams" do
    expect(Team.count_of_teams).to eq(32)
  end

end
