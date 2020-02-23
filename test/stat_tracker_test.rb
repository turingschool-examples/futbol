require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
                  games: "./test/fixtures/games_sample.csv",
                  game_teams: "./test/fixtures/game_teams_sample.csv",
                  teams: "./test/fixtures/teams_sample.csv"
                }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def teardown
    Game.games = {}
    Team.teams = {}
    GameTeam.game_teams = {}
  end

  def test_it_exists
    assert_instance_of StatTracker, StatTracker.new
  end

  def test_from_csv_returns_new_instance
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_create_items
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Team)

    assert_instance_of Team, Team.all[1]
  end

  def test_from_csv_loads_all_three_files
    assert_equal 100, Game.all.count
    # assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_sort_module
    assert_equal [1,2,3,4,5,6,7,8], @stat_tracker.sort(Game)
  end

  def test_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.54, @stat_tracker.percentage_home_wins
  end

  def test_percentage_away_wins
    assert_equal 0.43, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.03, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected =
    {
      "20122013" => 57,
      "20162017" => 4,
      "20142015" => 17,
      "20152016" => 16,
      "20132014" => 6
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.95, @stat_tracker.average_goals_per_game
  end

  def test_total_goals_per_season
    game = Game.all.values.first

    assert_equal 220, @stat_tracker.total_goals_per_season(game.season)
  end

  def test_average_goals_by_season
    expected =
    {
      "20122013" => 3.86,
      "20162017" => 4.75,
      "20142015" => 4.00,
      "20152016" => 3.88,
      "20132014" => 4.33
    }

    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_most_tackles
    game = Game.all.values.first

    assert_equal "Houston Dynamo", @stat_tracker.most_tackles(game.season)
  end

  def test_fewest_tackles
    game = Game.all.values.first

    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles(game.season)
  end

  def test_games_in_season
    game = Game.all.values.first

    assert_equal 57, @stat_tracker.games_in_season(game.season).length
  end
end
