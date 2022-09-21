require './lib/team'

RSpec.describe Team do
  let(:team) {Team.new(["1", "3", "Flying Squirrels", "FSQ", "Nut Hill Stadium", "/api/v1/teams/1"])}

  it "1. exists" do
    expect(team).to be_a(Team)
  end

  it "2. has readable attributes" do
    expect(team.team_id).to eq("1")
    expect(team.franchise_id).to eq("3")
    expect(team.team_name).to eq("Flying Squirrels")
    expect(team.abbreviation).to eq("FSQ")
    expect(team.stadium).to eq("Nut Hill Stadium")
    expect(team.link).to eq("/api/v1/teams/1")
  end

  it "3. has a readable hash attribute 'team_games' that is blank by default" do
    expect(team.team_games).to eq({})
  end

  it "4. lists the team information in a hash" do
    expect(team.team_labels).to eq({"team_id" => "1",
     "franchise_id" => "3",
     "team_name" => "Flying Squirrels",
     "abbreviation" => "FSQ",
     "link" => "/api/v1/teams/1"
    })
  end
end
