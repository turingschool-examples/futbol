require './lib/stat_tracker'
require './lib/team_stats'
require './modules/team_statistics'

describe TeamStatistics do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'can create a list of Team Stats' do
    team_stats = TeamStats.create_a_list_of_teams(@stat_tracker.teams)
    expect(team_stats.all? { |team| team.instance_of?(TeamStats) }).to eq(true)
  end

  it 'can return a hash of a teams info' do
    expected = {
      'team_id' => '18',
      'franchise_id' => '34',
      'team_name' => 'Minnesota United FC',
      'abbreviation' => 'MIN',
      'link' => '/api/v1/teams/18'
    }

    expect(@stat_tracker.team_info('18')).to eq expected
  end
end
