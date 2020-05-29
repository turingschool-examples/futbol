require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/stat_tracker"
require 'pry'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './test/data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_tracker_can_fetch_game_data
    assert_equal 60, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_tracker_can_fetch_team_data
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_tracker_can_fetch_game_team_data
    assert_equal 52, @stat_tracker.game_teams.count
  end

  def test_tracker_has_all_games_per_season
    assert_equal 57, @stat_tracker.all_games_per_season("20122013").count
    assert_instance_of Game,  @stat_tracker.all_games_per_season("20122013").first

    expected = @stat_tracker.all_games_per_season("20122013").map{|game| game.season}.uniq
    assert_equal 1, expected.size
    assert_equal "20122013", expected.first
  end

  def test_tracker_has_all_game_teams_per_season
    game_teams_in_a_season = @stat_tracker.all_game_teams_per_season("20122013")
    assert_equal 52, game_teams_in_a_season.count

    game_teams_in_a_season.each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end
end
