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

  it '#game_team_group_by_season' do
    expect(@stat_tracker.league.game_team_group_by_season("20122013")[2].game_id).to eq("2012030222")
  end

  it 'coaches_by_win_percentage' do
    expect(@stat_tracker.league.coaches_by_win_percentage("20122013")).to eq({"John Tortorella" => 0.00,
                  "Claude Julien" => 100.00})
  end

  it 'teams_by_accuracy' do
    expect(@stat_tracker.league.teams_by_accuracy("20122013")).to eq({"3" => 0.23529, "6" => 0.28571})
  end

  it 'teams_by_tackles' do
    expect(@stat_tracker.league.teams_by_tackles("20122013")).to eq({"3" => 77, "6" => 115})
  end

  it '#team_info' do
    expected = {
      "team_id" => "26",
      "franchise_id" => "14",
      "team_name" => "FC Cincinnati",
      "abbreviation" => "CIN",
      "link" => "/api/v1/teams/26"
    }
    expect(@stat_tracker.team_info("26")).to eq(expected)
  end

  it '#game_team_group_by_team' do
    expect(@stat_tracker.league.game_team_grouped_by_team("3").length).to eq(2)
  end

  it '#data_sorted_by_season' do
    data = @stat_tracker.league.all_game_teams
    expect(@stat_tracker.league.data_sorted_by_season(data)["2012"].length).to eq(5)
  end

  it '#seasons_by_wins' do
    expect(@stat_tracker.league.seasons_by_wins("3")).to eq({"20122013" => 0.00000})
    expect(@stat_tracker.league.seasons_by_wins("6")).to eq({"20122013" => 1.00000})
  end

  it '#wins_losses_tally' do
    expect(@stat_tracker.league.wins_losses_tally("3")).to eq({
      wins: 0,
      ties: 0,
      total_games: 2
    })
    expect(@stat_tracker.league.wins_losses_tally("6")).to eq({
      wins: 3,
      ties: 0,
      total_games: 3
    })
  end

  it '#goals_scored_in_game' do
    expect(@stat_tracker.league.goals_scored_in_game("3")).to eq([2,2])
    expect(@stat_tracker.league.goals_scored_in_game("6")).to eq([3,3,2])
  end
end 
