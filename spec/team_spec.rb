require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

RSpec.describe Team do
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
    @team = Team.new(@stat_tracker.game_team_data, @stat_tracker.game_data, @stat_tracker.team_data)
  end

  it 'exists' do
    expect(@team).to be_an_instance_of Team
  end
  
  it "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq expected
  end

  it 'can find seasonal wins' do
    expected = {
      "20122013"=>22,
      "20132014"=>49,
      "20142015"=>52,
      "20152016"=>39,
      "20162017"=>44,
      "20172018"=>24
    }

    expect(@stat_tracker.game_wins_per_season("3")).to eq(expected)
  end

  it 'can count season game totals' do
    expected = {
      "20122013"=>60,
      "20132014"=>107,
      "20142015"=>101,
      "20152016"=>87,
      "20162017"=>94,
      "20172018"=>82
    }
    expect(@stat_tracker.games_per_season("3")).to eq(expected)
  end

  it "#best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  it "#worst_season" do
    expect(@stat_tracker.worst_season("6")).to eq "20142015"
  end

  xit "#average_win_percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  end

  xit "#most_goals_scored" do
    expect(@stat_tracker.most_goals_scored("18")).to eq 7
  end

  xit "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
  end

  xit "#favorite_opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  xit "#rival" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end
end