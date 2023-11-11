require 'spec_helper'

RSpec.describe Team do
    before(:each) do
    @new_team = Team.new({:team_id => 1,:franchise_id => 23, :team_name => "Atlanta United", :abbreviation => "ATL", :stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"}, TeamList)
  end

  it 'exists' do
    expect(@new_team).to be_a(Team)
  end

  it 'has readable attributes' do
    expect(@new_team.team_id).to eq(1)
    expect(@new_team.franchise_id).to eq(23)
    expect(@new_team.team_name).to eq("Atlanta United")
    expect(@new_team.abbreviation).to eq("ATL")
    expect(@new_team.stadium).to eq("Mercedes-Benz Stadium")
    expect(@new_team.link).to eq("/api/v1/teams/1")
  end
end