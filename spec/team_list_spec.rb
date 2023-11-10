require 'spec_helper'

RSpec.describe TeamList do
  before(:each) do
    @new_teamlist = TeamList.new("./data/teams_subset.csv", StatTracker )
  end

  it 'exists' do
    expect(@new_teamlist).to be_a(TeamList)

    expect(@new_teamlist.teams).to be_a(Array)
    expect(@new_teamlist.teams[0]).to be_a(Team)
  end

  it 'can create teams' do
    @new_teamlist.create_teams("./data/teams_subset.csv")
    
    expect(@new_teamlist.teams.count).to eq(20)
  end
end
