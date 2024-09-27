require 'spec_helper'

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
    expect(@season.most_accurate_team("20142015")).to eq("DC United")
  end

  it 'can return the least accurate team per season' do
    expect(@season.least_accurate_team("20142015")).to eq("Sporting Kansas City")
  end

  it 'has an array of games in the season' do
    expect(@season.games_in_season).to all(be_an(Game))
    expect(@season.games_in_season.length).to eq(7)
  end

  it 'can return a hash of tackles by each team in the season' do
    expect(@season.tackles_by_team).to be_an(Hash)
    expect(@season.tackles_by_team["DC United"]).to eq(76)
  end

  it 'can return the team with the most/fewest tackes in the season' do
    expect(@season.most_tackles).to eq("Sporting Kansas City")
    expect(@season.fewest_tackles).to eq("DC United")
  end

  it 'can return shots by team per season avg' do
    expect(@season.shots_by_team_per_season_avg(20142015)).to eq( {"DC United"=>0.35, "FC Dallas"=>0.3333333333333333, "Houston Dynamo"=>0.2631578947368421, "Sporting Kansas City"=>0.0625})
  end

  it 'can show coach percentages' do
    expect(@season.coach_percentages).to eq({"Claude Julien"=>1.0, "Dan Bylsma"=>0.0, "Jon Cooper"=>0.67, "Alain Vigneault"=>0.33})
  end

end
