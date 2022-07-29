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

  it 'has an array of games in the season' do
    expect(@season.games_in_season).to all(be_an(Game))
    expect(@season.games_in_season.length).to eq(7)
  end

  it 'can return the team with the most/fewest tackes in the season' do
    expect(@season.most_tackles).to eq("Sporting Kansas City")
    expect(@season.least_tackles).to eq("DC United")
  end

end