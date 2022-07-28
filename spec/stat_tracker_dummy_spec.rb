require './lib/stat_tracker'

describe StatTracker do
  before(:all) do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 6
  end

  it '#lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end
  it '#returns the percentage of home team wins' do
    expect(@stat_tracker.percentage_home_wins).to eq 0.35
  end

  it '#returns the percentage of home team wins' do
    expect(@stat_tracker.percentage_home_wins).to eq 0.35
  end

  it '#returns the percentage of visitor team wins' do
    expect(@stat_tracker.percentage_vistor_wins).to eq 0.3
  end

  it '#returns the percentage of games tied' do
    expect(@stat_tracker.percentage_ties).to eq 0.35
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq(3.85)
  end

  it '#count_of_games_by_season' do
    expected = {
      "20122013" => 2,
      "20132014" => 6,
      "20142015" => 7,
      "20152016" => 5
    }

    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
  end

  it '#count_of_teams' do
    expect(@stat_tracker.count_of_teams).to eq (20)
  end

  it '#best offense' do
    expect(@stat_tracker.best_offense).to eq ("FC Dallas")
  end

  it '#worst offense' do
    expect(@stat_tracker.worst_offense).to eq ("Sporting Kansas City")
  end

  it '#average_goals_by_season' do
    expected = {
      "20122013" => 2.50,
      "20132014" => 3.67,
      "20142015" => 3.86,
      "20152016" => 4.60
    }
    expect(@stat_tracker.average_goals_by_season).to eq(expected)
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

  it '#least_accurate_team' do
    expect(@stat_tracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
  end

  it '#most_accurate_team' do
    expect(@stat_tracker.most_accurate_team("20122013")).to eq("FC Dallas")
  end

  it '#team_info' do
    expected = {
      "team_id" => "27",
      "franchise_id" => "28",
      "team_name" => "San Jose Earthquakes",
      "abbreviation" => "SJ",
      "link" => "/api/v1/teams/27"
    }
    expect(@stat_tracker.team_info("27")).to eq(expected)
  end

  it '#favorite_opponent' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
     @stat_tracker = StatTracker.from_csv(locations)

    expect(@stat_tracker.favorite_opponent("5")).to eq("Sky Blue FC")
    expect(@stat_tracker.favorite_opponent("28")).to eq("Minnesota United FC")
  end

  it '#rival' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'


    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
     @stat_tracker = StatTracker.from_csv(locations)

    expect(@stat_tracker.rival("5")).to eq("Philadelphia Union")
    expect(@stat_tracker.rival("18")).to eq("Los Angeles FC")
  end

  it '#best_season' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/amm_edited_games_teams_dummy.csv'
    
     locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    
    expect(@stat_tracker.best_season("3")).to eq("20142015")
    expect(@stat_tracker.best_season("6")).to eq("20122013")

  end
  
  it '#worst_season' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/amm_edited_games_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    expect(@stat_tracker.worst_season("3")).to eq("20122013")
    expect(@stat_tracker.worst_season("6")).to eq("20142015")
   end

  it '#winningest_coach' do
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
  end

  it '#worst_coach' do
    expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored("3")).to eq(2)
    expect(@stat_tracker.most_goals_scored("5")).to eq(1)
  end

  it '#fewest_goals_scored' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/amm_edited_games_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)

    expect(@stat_tracker.fewest_goals_scored("6")).to eq(1)
    expect(@stat_tracker.fewest_goals_scored("5")).to eq(0)
    expect(@stat_tracker.fewest_goals_scored("3")).to eq(1)
  end

  it '#average_win_percentage' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/amm_edited_games_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)

    expect(@stat_tracker.average_win_percentage("6")).to eq(0.67)
    expect(@stat_tracker.average_win_percentage("5")).to eq(0.40)
  end
end
