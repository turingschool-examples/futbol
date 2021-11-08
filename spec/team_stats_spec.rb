require 'rspec'
require './lib/team_stats'

describe TeamStats do 
  let(:team) {TeamStats.new}

  xit 'exists' do
    expect(team).to be_an_instance_of(TeamStats)
  end

  xit 'attributes' do
    expect(team.name).to eq()
  end
end