require './lib/teams'
require 'csv'

describe Team do
  before :each do
    @all_rows = CSV.read("data/teams.csv", headers: true)
    @teams = @all_rows.map do |row|
      Team.new(row)
    end
  end

  it "exists" do
    expect(@teams).to be_a(Array)
    expect(@teams[0]).to be_a(Team)
  end

  it "has attributes" do
    expect(@teams[0].team_id).to eq("1")
    expect(@teams[0].franchise_id).to eq("23")
    expect(@teams[0].team_name).to eq("Atlanta United")
    expect(@teams[0].abbreviation).to eq("ATL")
    expect(@teams[0].link).to eq("/api/v1/teams/1")
  end

  it "A hash with key/value pairs for the following attributes" do
    expected = {
      "team_id": "1",
      "franchise_id": "23",
      "team_name": "Atlanta United",
      "abbreviation": "ATL",
      "link": "/api/v1/teams/1"
    }

    expect(@teams.team_info("1")).to eq(expected)
    expect(@teams.team_info("2")).to eq(expected)
  end
end
