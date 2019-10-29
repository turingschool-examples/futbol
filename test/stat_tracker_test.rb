require './test/test_helper'
require './lib/game'
require 'CSV'

class StatTrackerTest < Minitest::Test
  def setup
    # using top 20 rows in each csv
    game_path = './data/dummy_games.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    home_wins = @stat_tracker.game_collection.games.values.count do |game|
      game.home_goals > game.away_goals
    end

    away_wins = @stat_tracker.game_collection.games.values.count do |game|
      game.home_goals < game.away_goals
    end
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes
    assert_equal 20, @stat_tracker.team_collection.teams.count
    assert_equal 20, @stat_tracker.game_collection.games.count
    # assert_equal 20, @stat_tracker.game_teams.count
  end

  ##############
  # game stats #
  ##############

  def test_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.45, @stat_tracker.percentage_home_wins
  end

  def test_percentage_away_wins
    assert_equal 0.45, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.10, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 5,
      "20132014" => 4,
      "20152016" => 3,
      "20162017" => 5,
      "20172018" => 3
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.9, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_per_season
    expected = {"20122013"=>3.6, "20132014"=>4.0, "20152016"=>4.33, "20162017"=>3.8, "20172018"=>4.0}
    assert_instance_of Hash, @stat_tracker.average_goals_by_season
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_seasons_helper_method
    assert_equal ["20122013", "20132014", "20152016", "20162017", "20172018"], @stat_tracker.game_collection.seasons
  end

  def test_games_by_seasons_helper_method
    assert_instance_of Game, @stat_tracker.game_collection.games_by_season["20122013"].first
    assert_equal 5, @stat_tracker.game_collection.games_by_season["20122013"].length
  end

  ##############
  #league stats#
  ##############

  def test_team_count
    assert_equal 20, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_most_visitor_goals
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_most_home_goals
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end
end
