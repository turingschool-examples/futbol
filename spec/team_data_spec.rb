require 'spec_helper'
describe TeamData do
  it 'can import team data' do
    dataset = TeamData.new
    dataset.add_teams
    expect(dataset.teams[0].team_id).to eq("1")
  end
end