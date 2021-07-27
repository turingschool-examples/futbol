require './team'

RSpec.describe Team do
  context "it's a futbol team" do
    team = Team.new({
      team_id: "4",
      franchise_id: "16",
      team_name: "Chicago Fire",
      abbreviation: "CHI",
      link: "/api/v1/teams/4"
    })

    it "exists" do
      expect(team).to be_a(Team)
    end

    it "has readable attributes" do
      expect(team.team_id).to eq("4")
      expect(team.franchise_id).to eq("16")
      expect(team.team_name).to eq("Chicago Fire")
      expect(team.abbreviation).to eq("CHI")
    end

    it "makes a hash of team info" do
      expect(team.team_info).to eq({
        team_id: "4",
        franchise_id: "16",
        team_name: "Chicago Fire",
        abbreviation: "CHI",
        link: "/api/v1/teams/4"
      })
    end
  end
end
