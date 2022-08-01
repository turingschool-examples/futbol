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

  it 'can return a hash of opponent_win_percentages' do
    expected = {"DC United"=>0.6666666666666666, "FC Dallas"=>1.0}
    expect(@team.opponent_win_percentages).to eq(expected)
  end

  it 'can return the opponent team with the highest/lowest win percentage against them' do
    expect(@team.rival).to eq("FC Dallas")
    expect(@team.favorite_opponent).to eq("DC United")
  end

  it 'can return its win percentages for each season' do
    expected = {
      20122013 => 0.00,
      20142015 => 0.3333333333333333
    }
    expect(@team.win_percentages_by_season).to eq(expected)
  end

  it 'can return the teams best/worst seasons' do
    expect(@team.best_season).to eq("20142015")
    expect(@team.worst_season).to eq("20122013")
  end

  it 'can return the total home and away goals' do
    expected = [2, 2, 1, 2, 1, 0, 5, 0]
    expect(@team.home_and_away_goals).to eq(expected)
  end

  it 'can return the most/fewest goals of a team' do
    expect(@team.most_goals_scored).to eq(5)
    expect(@team.fewest_goals_scored).to eq(0)
  end

  it 'can return total goals when passed the argument of home or away key' do
    expect(@team.total_goals_per_side(:home_team)).to eq 3
    expect(@team.total_goals_per_side(:away_team)).to eq 10
  end

end
