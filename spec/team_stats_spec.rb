require "simplecov"
require "CSV"
require "./lib/stat_tracker"
require "./lib/team_stats"
require "pry"

SimpleCov.start
RSpec.describe TeamStatistics do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams_test.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @team_stats = TeamStatistics.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)

  end

  it "exists" do
    expect(@team_stats).to be_a(TeamStatistics)
  end

    it "can show team info" do
    result = {
             team_id: "3",
             franchise_id: "10",
             team_name: "Houston Dynamo",
             abbreviation: "HOU",
             link: "/api/v1/teams/3"}

    expect(@team_stats.team_info("3")).to eq(result)
  end

  it "can get games won by a team" do
    expect(@team_stats.games_won("3").length).to eq(2)
    expect(@team_stats.games_won("6").length).to eq(9)
  end

  it "can get average win percentage" do
    expect(@team_stats.average_win_percentage("3")).to eq(0.11764705882352941)
    expect(@team_stats.average_win_percentage("6")).to eq(1)
  end

  it "can get all games played by team" do
    expect(@team_stats.all_games_played("3").length).to eq(17)
  end

  it "can get most goals scored" do
    expect(@team_stats.most_goals_scored("3")).to eq(3)
  end

  it "can get fewest goals scored" do
    expect(@team_stats.fewest_goals_scored("3")).to eq(0)
  end

  it "can get best season" do
    expect(@team_stats.best_season("3")).to eq("20122013")
  end

  it "can get all seasons" do
    expect(@team_stats.all_seasons).to eq(["20122013", "20162017", "20142015", "20152016", "20132014"])
  end

  it 'can get win percentage for a season' do
    expect(@team_stats.season_win_percentage('20122013', '3')).to eq(0.16666666666666666)
  end

  it 'can get worst season' do
    expect(@team_stats.worst_season('3')).to eq("20162017")
  end

  it "can get favorite opponent" do
    expect(@team_stats.favorite_opponent("3")).to eq("Portland Timbers")
  end

  it 'can get all opponents it has played against' do
    expect(@team_stats.all_opponents("3").length).to eq(3)
  end

  it 'can get average win percentage against an opponent' do
    expect(@team_stats.team_opponent_win_percentage('6', '3')).to eq(0.0)
    expect(@team_stats.team_opponent_win_percentage('15', '3')).to eq(0.2857142857142857)
  end

  it 'can get biggest rival' do
    expect(@team_stats.rival("16")).to eq("FC Cincinnati")
  end
end
