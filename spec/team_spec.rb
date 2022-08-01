require "./lib/team"

RSpec.describe Team do

  it 'exists and has readable attributes' do
    info = {
      team_id: "1",
      franchiseId: "23",
      teamName: "Atlanta United",
      abbreviation: "ATL",
      link: "/api/v1/teams/1"
            }
    team = Team.new(info)
    expect(team).to be_a(Team)
    expect(team.team_id).to eq("1")
    expect(team.franchise_id).to eq("23")
    expect(team.team_name).to eq("Atlanta United")
    expect(team.abbv).to eq("ATL")
    expect(team.link).to eq("/api/v1/teams/1")
  end
end
