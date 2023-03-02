require 'rspec'
require './lib/game'
require './lib/team'

RSpec.describe Team do
  before(:each) do
    hash = {
      :team_id => 1,
      :franchiseid => 23,
      :teamname => "Atlanta United",
      :abbreviation => "ATL",
      :link => "/api/v1/teams/1"
    } #are the above strings actually strings in the csv? arrays right?
    #can we fix the camel case?
    @team = Team.new(hash)
  end

  it 'exists' do
    expect(@team).to be_a(Team)
  end

  it 'the team has attributes' do
    expect(@team.team_id).to eq(1)
    expect(@team.franchise_id).to eq(23)
    expect(@team.team_name).to eq("Atlanta United")
    expect(@team.abbreviation).to eq("ATL")
    expect(@team.link).to eq("/api/v1/teams/1")
  end
end