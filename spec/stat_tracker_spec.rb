require "./lib/stat_tracker"


RSpec.describe(StatTracker) do
  before(:each) do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"
    locations = {games: game_path, teams: team_path, game_teams: game_teams_path}
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it("1. exists") do
    expect(@stat_tracker).to(be_an_instance_of(StatTracker))
  end

  it("3. can load an array of multiple CSVs") do
    expect(@stat_tracker.games).to(be_a(CSV::Table))
    expect(@stat_tracker.teams).to(be_a(CSV::Table))
    expect(@stat_tracker.game_teams).to(be_a(CSV::Table))
  end

  it("#1 has highest_total_score") do
    expect(@stat_tracker.highest_total_score).to(eq(11))
  end

  it("#2 lowest_total_score") do
    expect(@stat_tracker.lowest_total_score).to(eq(0))
  end

  it("#3 Percentage of games that a home team has won (rounded to the nearest 100th)") do
    expect(@stat_tracker.percentage_home_wins).to(eq(0.44))
  end

  it("#4 percentage_visitor_wins") do
    expect(@stat_tracker.percentage_visitor_wins).to(eq(0.36))
  end

  it("#5 percentage_ties") do
    expect(@stat_tracker.percentage_ties).to(eq(0.20))
  end

  it("#6 count_of_games_by_season") do
    expected = {
      "20122013" => 806,
      "20162017" => 1317,
      "20142015" => 1319,
      "20152016" => 1321,
      "20132014" => 1323,
      "20172018" => 1355,
    }
    expect(@stat_tracker.count_of_games_by_season).to(eq(expected))
  end
end
