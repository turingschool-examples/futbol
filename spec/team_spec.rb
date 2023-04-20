require 'spec_helper'

RSpec.describe Team do
  it 'exists' do
    team = Team.new(team)
    expect(team).to be_a(Team)
  end

  it 'has attributes' do
    team = Team.new(team)
    expect(team.team_id).to eq()
    expect(team.name).to eq()
  end
end