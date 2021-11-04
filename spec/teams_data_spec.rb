require './lib/stat_tracker'
require './lib/teams_data'

RSpec.describe TeamsData do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end



  it 'is exists' do
    team_obj = TeamsData.new(@stat_tracker)
    expect(team_obj).to be_instance_of(TeamsData)
  end

  it 'can store and access teams data' do
    team_obj = TeamsData.new(@stat_tracker)

    expect(team_obj.teamData).to eq(@stat_tracker.teams)
  end
end
