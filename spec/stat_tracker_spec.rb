require "./lib/stat_tracker"
require "./lib/league_stats"
require "./lib/season_stats"
require "./lib/data_warehouse"
require "pry"


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
    expect(@stat_tracker.data_warehouse.games).to(be_a(CSV::Table))
    expect(@stat_tracker.data_warehouse.teams).to(be_a(CSV::Table))
    expect(@stat_tracker.data_warehouse.game_teams).to(be_a(CSV::Table))
  end

  it("A hash with key/value pairs for the following attributes") do
    expected = {
      "team_id" => "1",
      "franchise_id" => "23",
      "team_name" => "Atlanta United",
      "abbreviation" => "ATL",
      "link" => "/api/v1/teams/1",
    }
    expect(@stat_tracker.team_info("1")).to(eq(expected))
  end

  it("seasons with highest win percentange for team") do
    expect(@stat_tracker.best_season("16")).to(eq("1.8"))
  end

  it("seasons with lowest win percentage for team") do
    expect(@stat_tracker.worst_season("16")).to(eq("0.6"))
  end

  it("average win percentage of all games for a team") do
    expect(@stat_tracker.average_win_percentage("16")).to(eq(0.05))
  end

  it("highest number of goals scored in a game") do
    expect(@stat_tracker.most_goals_scored("16")).to(eq(4))
  end

  it("lowest number of goals scored in a game") do
    expect(@stat_tracker.fewest_goals_scored("16")).to(eq(0))
  end

  it("favorite opponent") do
    expect(@stat_tracker.favorite_opponent("16")).to(eq("Philadelphia Union"))
  end

  it("rival") do
    expect(@stat_tracker.rival("16")).to(eq("LA Galaxy"))
  end

  describe("League Methods") do
    it("can count teams") do
      expect(@stat_tracker.count_of_teams).to(eq(32))
    end

    it("can find best offense") do
      expect(@stat_tracker.best_offense).to(eq("FC Dallas"))
    end

    it("can find worst offense") do
      expect(@stat_tracker.worst_offense).to(eq("Sky Blue FC"))
    end

    it("can find highest scoring visitor") do
      expect(@stat_tracker.highest_scoring_visitor).to(eq("Columbus Crew SC"))
    end

    it("can find highest scoring home team") do
      expect(@stat_tracker.highest_scoring_home_team).to(eq("San Jose Earthquakes"))
    end

    it("can find lowest scoring visitor") do
      expect(@stat_tracker.lowest_scoring_visitor).to(eq("Chicago Fire"))
    end

    it("can find lowest scoring home team") do
      expect(@stat_tracker.lowest_scoring_home_team).to(eq("Washington Spirit FC"))
    end
  end

  context("Season statistics") do
    it("S1. has a method for winningest_coach") do
      expect(@stat_tracker.data_warehouse.game_teams[:head_coach]).to(include(@stat_tracker.winningest_coach("20122013")))
      expect(@stat_tracker.winningest_coach("20122013")).to(be_a(String))
    end

    it("S2. has a method for worst_coach") do
      expect(@stat_tracker.data_warehouse.game_teams[:head_coach]).to(include(@stat_tracker.worst_coach("20122013")))
      expect(@stat_tracker.worst_coach("20122013")).to(be_a(String))
    end

    it("S3. can tell most_accurate_team") do
      expect(@stat_tracker.data_warehouse.teams[:teamname]).to(include(@stat_tracker.most_accurate_team("20122013")))
      expect(@stat_tracker.most_accurate_team("20122013")).to(be_a(String))
    end

    it("S3. can tell least_accurate_team") do
      expect(@stat_tracker.data_warehouse.teams[:teamname]).to(include(@stat_tracker.least_accurate_team("20122013")))
      expect(@stat_tracker.least_accurate_team("20122013")).to(be_a(String))
    end

    it("can tell the team with the most tackles in a season") do
      expect(@stat_tracker.data_warehouse.teams[:teamname]).to(include(@stat_tracker.most_tackles("20122013")))
      expect(@stat_tracker.most_tackles("20122013")).to(be_a(String))
    end

    it("can tell the team with the fewest tackles in a season") do
      expect(@stat_tracker.data_warehouse.teams[:teamname]).to(include(@stat_tracker.fewest_tackles("20122013")))
      expect(@stat_tracker.fewest_tackles("20122013")).to(be_a(String))
    end
  end
end
