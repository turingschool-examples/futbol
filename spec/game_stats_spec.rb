require "./lib/stat_tracker"
require "./lib/league_stats"
require "./lib/season_stats"
require "./lib/data_warehouse"
require "./lib/game_stats"
require "pry"


RSpec.describe(StatTracker) do
  before(:each) do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"
    locations = {games: game_path, teams: team_path, game_teams: game_teams_path}
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it("#1 has highest_total_score") do
    expect(@stat_tracker.highest_total_score).to(eq(11))
  end

  it("#2 lowest_total_score") do
    expect(@stat_tracker.lowest_total_score).to(eq(0))
  end

  it("#3 Percentage of games that a home team has won ") do
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

  it("(helper) total goals") do
    expect(@stat_tracker.total_goals).to(eq(31413))
  end

  it("(helper)total_games") do
    expect(@stat_tracker.total_games).to(eq(7441))
  end

  it("#7 average number of goals scored in a game across all seasons including both home and away goals") do
    expect(@stat_tracker.average_goals_per_game).to(eq(4.22))
  end

  it("#8 average_goals_by_season") do
    expected = {
      "20122013" => 4.12,
      "20162017" => 4.23,
      "20142015" => 4.14,
      "20152016" => 4.16,
      "20132014" => 4.19,
      "20172018" => 4.44,
    }
    expect(@stat_tracker.average_goals_by_season).to(eq(expected))
  end
end
