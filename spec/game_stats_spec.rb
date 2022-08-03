require "./lib/game_stats"
require "./lib/game"
require "./lib/game_teams"
require "./lib/teams"
require "./lib/stat_tracker"

describe GameStats do
  before :each do
    game_path = "./data/games.csv"
    @game_stats = GameStats.from_csv(game_path)
    @game_stats.extend(Helpable)
  end

  it "exists" do
    expect(@game_stats).to be_a(GameStats)
  end

  it "can calculate the games highest total score" do
    expect(@game_stats.highest_total_score).to eq(11)
  end

  it "can calculate the games lowest total score" do
    expect(@game_stats.lowest_total_score).to eq(0)
  end

  it "can calculate the games precentage home wins" do
    expect(@game_stats.percentage_home_wins).to eq(0.44)
  end

  it "can calculate the games percentage visitor wins" do
    expect(@game_stats.percentage_visitor_wins).to eq(0.36)
  end

  it "can calculate the games percentage ties" do
    expect(@game_stats.percentage_ties).to eq(0.20)
  end

  it "can calculate the games count of games by season" do
    expected = {
      "20122013" => 806,
      "20162017" => 1317,
      "20142015" => 1319,
      "20152016" => 1321,
      "20132014" => 1323,
      "20172018" => 1355,
    }

    expect(@game_stats.count_of_games_by_season).to eq(expected)
  end

  it "can calculate the games average goals per game" do
    expect(@game_stats.average_goals_per_game).to eq(4.22)
  end

  it "can calculate the games average goals by season" do
    expected = {
      "20122013" => 4.12,
      "20162017" => 4.23,
      "20142015" => 4.14,
      "20152016" => 4.16,
      "20132014" => 4.19,
      "20172018" => 4.44,
    }
    expect(@game_stats.average_goals_by_season).to eq(expected)
  end

  it "can calculate which team was the highest scoring visitor" do
    expect(@game_stats.visitor_teams_average_score.count).to eq(32)
  end

  it "can tell which season is a teams best" do
    expect(@game_stats.best_season("6")).to eq("20132014")
  end

  it "can calculate which team was the highest scoring home team" do
    expect(@game_stats.home_teams_average_score.count).to eq(32)
  end

  it "can identify all games that correspond to a certain season id" do #helper method
    game_path_dummy = "./spec/fixtures/dummy_game.csv"
    game_stats_dummy = GameStats.from_csv(game_path_dummy)

    expected = ["2012030221",
               "2012030222",
               "2012030223",
               "2012030224",
               "2012030225",
               "2012030311",
               "2012030312",
               "2012030313",
               "2012030314"]
    expect(game_stats_dummy.games_by_season("20122013")).to eq(expected)
  end
end
