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
    @team = Team.new(@stat_tracker.game_team_data, @stat_tracker.game_data, @stat_tracker.team_dat)
  end

  it 'exists' do
    expect(@team).to be_an_instance_of Team
  end
  
  xit "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq expected
  end

  xit "#best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  xit "#worst_season" do
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
end