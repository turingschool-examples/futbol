require './lib/teams_stats'
require './lib/teams'

describe TeamsStats do
  before :each do
    teams_path = "./data/teams.csv"
    @team_stats = TeamsStats.from_csv(teams_path)
    @team_stats.extend(Helpable)
  end

  it 'exists' do
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

end
