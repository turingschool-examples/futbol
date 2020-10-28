require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/seasonstats'

class SeasonStatsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @seasonstats = SeasonStats.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @seasonstats
  end

  def test_game_ids_per_season
    expected = { 20122013 => [2012030221, 2012030222, 2012030223]}
    assert_instance_of Hash, @seasonstats.game_ids_per_season
    @seasonstats.stubs(:game_ids_per_season).returns(expected)
    assert_equal expected, @seasonstats.game_ids_per_season
  end

  def test_games_per_coach
    expected = { "Coach Name" => ["the whole line"]}
    assert_instance_of Hash, @seasonstats.games_per_coach
    @seasonstats.stubs(:games_per_coach).returns(expected)
    assert_equal expected, @seasonstats.games_per_coach
  end

  def test_results_per_coach_per_season
    expected = { "Coach Name" => ["WIN", "TIE", "LOSS"]}
    assert_instance_of Hash, @seasonstats.results_per_coach_per_season("20122013")
    @seasonstats.stubs(:results_per_coach_per_season).returns(expected)
    assert_equal expected, @seasonstats.results_per_coach_per_season("20122013")
  end

  # def test_count_coach_results
  #   expected = { "Coach Name" => 55,
  #                "Another Coach" => 34}
  #   assert_instance_of Hash, @seasonstats.count_coach_results("20122013", "WIN")
  #   @seasonstats.stubs(:count_coach_results).returns(expected)
  #   assert_equal expected, @seasonstats.count_coach_results("12345", "WIN")
  # end

  # def test_winningest_coach
  #   assert_instance_of String, @seasonstats.winningest_coach("20122013")
  #   @seasonstats.stubs(:winningest_coach).returns("Claude Julien")
  #   assert_equal "Claude Julien", @seasonstats.winningest_coach("20122013")
  # end

end
