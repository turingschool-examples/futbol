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

end
