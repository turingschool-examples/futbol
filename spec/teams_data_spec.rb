require './lib/stat_tracker'
require './lib/teams_data'

RSpec.describe TeamsData do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams_test.csv'
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

  # it 'can return #team_info' do
  #   team_obj = TeamsData.new(@stat_tracker)
  #   team_obj.team_info(18)
  #
  #   expected = {
  #     team_id: 18,
  #     franchiseId: 34,
  #     teamName: "Minnesota United FC",
  #     abbreviation: MIN,
  #     Stadium: "Allianz Field",
  #     link: "/api/v1/teams/18"
  #   }
  #   expected(TeamsData.team_info(team_id)).to eq(expected)
  # end

  it 'parses season data' do
    team_obj = TeamsData.new(@stat_tracker)
    expect(team_obj.parse_seasons.count).to eq(4)
  end
end
