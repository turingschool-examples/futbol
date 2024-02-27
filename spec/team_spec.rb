require './spec/spec_helper'

RSpec.describe Team do

  it 'exists' do
    new_team = Team.new
    expect(new_team).to be_a Team
  end

  it 'creates a team object' do
    new_team = Team.new("1", "Atlanta United")
    expect(new_team).to be_an_instance_of Team
  end

end