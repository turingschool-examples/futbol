require './lib/league'
require './lib/game'

describe League do
  before do
    game_path = './data/games_dummy_small.csv'
    team_path = './data/teams_dummy_small.csv'
    game_teams_path = './data/game_teams_dummy_small.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '#total_goals' do
    expect(@stat_tracker.league.total_goals).to eq([1, 6, 1, 6, 5])
  end

  it '#games_by_season' do
    expected_hash = {"20132014"=>1, "20142015"=>2, "20152016"=>2}

    expect(@stat_tracker.league.games_by_season).to eq(expected_hash)
  end

  it '#team_names' do
    expect(@stat_tracker.league.team_names).to eq(["Atlanta United", "Chicago Fire", "FC Cincinnati", "DC United", "FC Dallas"])
  end

  it '#goals_by_team_id' do
    expected_hash = {"3"=>[2, 2], "6"=>[3, 3, 2]}
    expect(@stat_tracker.league.goals_by_team_id).to eq(expected_hash)
  end

  it '#avg_goals_by_team_id' do
    expected_hash = {"3"=>2.0, "6"=>2.67}
    expect(@stat_tracker.league.avg_goals_by_team_id).to eq(expected_hash)
  end

  it '#team_id_to_team_name' do
    expect(@stat_tracker.league.team_id_to_team_name("4")).to eq("Chicago Fire")
  end
end
