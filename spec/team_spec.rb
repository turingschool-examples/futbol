require './spec_helper'

RSpec.describe Team do
  before(:each) do
    sample_data = {
      team_id: "1", 
      franchiseid: "23", 
      teamname: "Atlanta United",
      abbreviation: "ATL", 
      stadium: "Mercedes-Benz Stadium", 
      link: "/api/v1/teams/1", 
    }
    @team = Team.new(sample_data)
  end

  it 'exists' do
    expect(@team).to be_a(Team)
  end

  it 'has a team_id' do
    expect(@team.team_id).to eq("1")
  end

  it 'has a franchise_id' do
    expect(@team.franchise_id).to eq("23")
  end

  it 'has a team_name' do
    expect(@team.team_name).to eq("Atlanta United")
  end

  it 'has an abbreviation' do
    expect(@team.abbreviation).to eq("ATL")
  end

  it 'has a stadium' do
    expect(@team.stadium).to eq("Mercedes-Benz Stadium")
  end

  it 'has a link' do
    expect(@team.link).to eq("/api/v1/teams/1")
  end
end