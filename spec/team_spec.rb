require './lib/stat_tracker'

RSpec.describe Team do

  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    #All tests in the spec file are you Houston Dynamo!
    @team = stat_tracker.teams[3]
  end

  it 'exists and has a name' do
    expect(@team).to be_an(Team)
    expect(@team.team_name).to eq("Houston Dynamo")
  end

  it 'can return the total goals scored by a team over all games' do
    expect(@team.total_overall_goals).to eq(13)
  end

end