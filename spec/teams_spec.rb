require './lib/teams'
require 'csv'

describe Teams do
  before :each do
    @teams =   Teams.new(
    { team_id: "1",
         franchiseId: "23",
         teamName: "Atlanta United",
         abbreviation: "ATL",
         Stadium: "Mercedes-Benz Stadium",
         link: "/api/v1/teams/1" })
       end

  it 'exists' do
    expect(@teams).to be_instance_of(Teams)
  end

  it 'reads the correct team_id' do
    expect(@teams.team_id).to eq("1")
  end

  it 'reads the correct abbreviation' do
    expect(@teams.abbreviation).to eq("ATL")
  end

end
