require "pry"
require "rspec"
require "csv"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"
require_relative "../lib/games"
require_relative "../lib/teams"
require_relative "../lib/game_teams"

RSpec.describe StatTracker do
  before :each do
    game_path = "./data/test_games.csv"
    team_path = "./data/test_teams.csv"
    game_teams_path = "./data/test_game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a StatTracker
  end

  xit "checks highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 6
  end

  xit "checks lowest_total_score" do
    # Lowest sum of the winning and losing teams' scores
    # Integer
  end

  xit "checks percentage_home_wins" do
    # Percentage of games that a home team has won (rounded to the nearest 100th)
    # Float
  end

  xit "checks percentage_visitor_wins" do
    # Percentage of games that a visitor has won (rounded to the nearest 100th)
    # Float
  end

  xit "checks percentage_ties" do
    # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
    # Float
  end

  xit "checks count_of_games_by_season" do
    # A hash with season names (e.g. 20122013) as keys and counts of games as values
    # Hash
  end

  xit "checks average_goals_per_game" do
    # Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
    # Float
  end

  xit "checks average_goals_by_season" do
    # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
    # Hash
  end
  # End Game Statistics methods
end
