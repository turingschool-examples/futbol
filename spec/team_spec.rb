require './spec/spec_helper'

RSpec.describe Team do

  it 'exists' do
    new_team = Team.new("1", "Atlanta United")
    expect(new_team).to be_an_instance_of Team
  end

  it 'has a name and an id' do
    new_team = Team.new("1", "Atlanta United")
    expect(new_team.id).to eq 1
    expect(new_team.name).to eq "Atlanta United"
  end

end