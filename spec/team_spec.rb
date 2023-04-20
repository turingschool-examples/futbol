require 'spec_helper'

RSpec.describe Team do
  before(:each) do
    @team1 = Team.new(team_id: "5", name: "The WallFlowers")
  end

  it 'exists' do
    team = Team.new(team)
    expect(team).to be_a(Team)
  end

  it 'has attributes' do
    team = Team.new(team)
    expect(team.team_id).to be_a(String)
    expect(team.name).to be_a(String)
  end
end