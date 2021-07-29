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
    expect(@team_stats.games_won("3")).to eq([])
    expect(@team_stats.games_won("6").length).to eq(9)
  end

  it "can get average win percentage" do
    expect(@team_stats.average_win_percentage("3")).to eq(0)
    expect(@team_stats.average_win_percentage("6")).to eq(1)
  end

  it "can get all games played by team" do
    expect(@team_stats.all_games_played("3").length).to eq(5)
  end

  it "can get most goals scored" do
    expect(@team_stats.most_goals_scored("3")).to eq(2)
  end

  it "can get fewest goals scored" do
    expect(@team_stats.fewest_goals_scored("3")).to eq(1)
  end

  # it "can get best season" do
  #   expect(@team_stats.best_season("3")).to eq("")
  # end

  it "can get all seasons" do
    expect(@team_stats.all_seasons).to eq(["20122013"])
  end

  # it "can get lowest win percentage" do
  #   expect(@team_stats.lowest_win_percentage("3")).to eq(0)
  # end

  # it "can get favorite opponent" do
  #   expect(@team_stats.favorite_opponent("3")).to eq("string")
  # end
end
