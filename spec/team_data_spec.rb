require 'spec_helper'
describe TeamData do
  before(:each) do
    @dataset = TeamData.new
    @dataset.add_teams
  end

  it 'can import team data' do
    expect(@dataset.teams[0].team_id).to eq("1")
  end

  it 'can return a count of teams' do
    expect(@dataset.count_of_teams).to eq(32)
  end
end