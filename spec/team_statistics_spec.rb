# require 'simplecov'
# SimpleCov.start
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
    expect(@stat_tracker.teams.all? { |team| team.instance_of?(TeamStats) }).to eq(true)
  end

  it 'can return a hash of a teams info' do
    expected = {
      'team_id' => '1',
      'franchise_id' => '23',
      'team_name' => 'Atlanta United',
      'abbreviation' => 'ATL',
      'link' => '/api/v1/teams/1'
    }

    expect(@stat_tracker.team_info('1')).to eq expected
  end

  it 'can produce best season for a team' do
    expect(@stat_tracker.best_season('6')).to eq '20132014'
  end

  it 'can produce worst season for a team' do
    expect(@stat_tracker.worst_season('6')).to eq '20142015'
  end

  it 'can produce average win percentage of a team' do
    expect(@stat_tracker.average_win_percentage('6')).to eq 0.49
  end

  it 'can produce the highest amount of goals of a single game for a team' do
    expect(@stat_tracker.most_goals_scored('18')).to eq 7
  end

  it 'can produce the fewest amount of goals of a single game for a team' do
    expect(@stat_tracker.fewest_goals_scored('18')).to eq 0
  end

  it 'can produce the team that wins against a team the least' do
    expect(@stat_tracker.favorite_opponent('18')).to eq 'DC United'
  end

  it 'can produce the team that wins against a team the most' do
    expect(@stat_tracker.rival('18')).to eq('Houston Dash').or(eq('LA Galaxy'))
  end
end
