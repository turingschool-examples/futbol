require 'spec_helper.rb'

RSpec.describe Team do
  it "can initialize" do
    team = Team.new("1", "Atlanta United")

    expect(team.team_id).to eq "1"
    expect(team.team_name).to eq "Atlanta United"
  end
end
