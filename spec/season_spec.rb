require './lib/stat_tracker'

RSpec.describe Season do

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

    # All tests for Season are for the 2014-2015 season!
    @season = stat_tracker.seasons[20142015]
  end

  it 'exists and has an id' do
    expect(@season).to be_an(Season)
    expect(@season.season_id).to eq(20142015)
  end

  it 'can return the most accurate team per season' do
    expect(@season.most_accurate_team).to eq('Sporting Kansas City')
  end

  it 'can return the least accurate team per season' do
    expect(@season.least_accurate_team).to eq('DC United')
  end
end
