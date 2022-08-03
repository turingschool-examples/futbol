require "./lib/teams_stats"
require "./lib/teams"

describe TeamsStats do
  before :each do
    teams_path = "./data/teams.csv"
    @team_stats = TeamsStats.from_csv(teams_path)
  end

  it "exists" do
    expect(@team_stats).to be_a(TeamsStats)
  end

  it "can count the total number of teams" do
    expect(@team_stats.count_of_teams).to eq(32)
  end

  it "can create a hash with team_id, franchise_id, team_name, abbreviation, and link " do
    expect(@team_stats.team_info("18")).to eq({
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18",
    })
  end

  it "gives a hash of team id to team name" do
    team_path = "./spec/fixtures/dummy_teams.csv"

    @teams_stats_dummy = TeamsStats.from_csv(team_path)
    expect(@teams_stats_dummy.team_id_to_name.length).to eq(9)
    expect(@teams_stats_dummy.team_id_to_name).to be_a(Hash)
    expect(@teams_stats_dummy.team_id_to_name.keys).to eq(["1", "4", "26", "14", "6", "3", "5", "17", "28"])
    expect(@teams_stats_dummy.team_id_to_name.values).to eq(["Atlanta United",
                                                             "Chicago Fire",
                                                             "FC Cincinnati",
                                                             "DC United",
                                                             "FC Dallas",
                                                             "Houston Dynamo",
                                                             "Sporting Kansas City",
                                                             "LA Galaxy",
                                                             "Los Angeles FC"])
  end
end
