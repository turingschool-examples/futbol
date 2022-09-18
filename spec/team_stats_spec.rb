require'csv'
require'rspec'
require'./lib/team_stats.rb'

RSpec.describe TeamStats do
  before(:each) do
    TeamStats.from_csv_paths({game_csv:'./data/games.csv', gameteam_csv:'./data/game_teams.csv', team_csv:'./data/teams.csv'})
  end

  it "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }
    expect(TeamStats.team_info("18")).to eq expected
  end

  it "#best_season" do
    expect(TeamStats.best_season("6")).to eq "20132014"
  end

  it "#worst_season" do
    expect(TeamStats.worst_season("6")).to eq "20142015"
  end

  it "#average_win_percentage" do
    expect(TeamStats.average_win_percentage("6")).to eq 0.49
  end

  it "#most_goals_scored" do
    expect(TeamStats.most_goals_scored("18")).to eq 7
  end

  it "#fewest_goals_scored" do
    expect(TeamStats.fewest_goals_scored("18")).to eq 0
  end

  it "#favorite_opponent" do
    expect(TeamStats.favorite_opponent("18")).to eq "DC United"
  end

  it "#rival" do
    expect(TeamStats.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end
end
