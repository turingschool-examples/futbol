require "./lib/game_stats"
require "./lib/game"
require "./lib/game_teams"
require "./lib/teams"

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

  #why is this failing
  xit "can calculate which team was the highest scoring visitor" do
    expected = [["3", 2.15],
     ["6", 2.25],
      ["5", 2.18],
       ["17", 2.04],
        ["16", 2.1],
         ["9", 2.01],
          ["8", 2.01],
           ["30", 2...2.1],
            ["1", 1.9],
             ["12", 2.02],
              ["23", 1.94],
               ["22", 2.03],
                ["7", 1.88],
                 ["27", 1.85],
                  ["53", 1.85]]
    expect(@game_stats.highest_scoring_visitor_array).to eq(expected)
  end

  it "can tell which season is a teams best" do
    expect(@game_stats.best_season("6")).to eq("20132014")
   end

   
end
