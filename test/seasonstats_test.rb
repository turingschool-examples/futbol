require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/seasonstats'

class SeasonStatsTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

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
    expected = {"20122013"=> ["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235", "2012030236", "2012030237", "2012030121", "2012030122", "2012030123", "2012030124", "2012030125", "2012030151", "2012030152", "2012030153", "2012030154", "2012030155", "2012030181", "2012030182", "2012030183", "2012030184", "2012030185", "2012030186", "2012030161", "2012030162", "2012030163", "2012030164", "2012030165", "2012030166", "2012030167", "2012030111", "2012030112", "2012030113", "2012030114", "2012030115", "2012030116", "2012030131", "2012030132", "2012030133", "2012030134", "2012030135", "2012030136", "2012030137", "2012030321", "2012030322"], "20162017"=>["2016030165"], "20152016"=>["2015030311"]}
    assert_equal expected, @seasonstats.game_ids_per_season
  end

  def test_games_in_season
    expected = 4
    assert_equal expected, @seasonstats.games_in_season("20122013").count
  end

  # def test_games_per_coach
  #   expected = { "Coach Name" => ["the whole line"]}
  #   assert_instance_of Hash, @seasonstats.games_per_coach
  #   @seasonstats.stubs(:games_per_coach).returns(expected)
  #   assert_equal expected, @seasonstats.games_per_coach
  # end

  # def test_results_per_coach_per_season
  #   expected = { "Coach Name" => ["WIN", "TIE", "LOSS"]}
  #   assert_instance_of Hash, @seasonstats.results_per_coach_per_season("20122013")
  #   @seasonstats.stubs(:results_per_coach_per_season).returns(expected)
  #   assert_equal expected, @seasonstats.results_per_coach_per_season("20122013")
  # end
  #
  # def test_count_coach_results
  #   expected = { "Coach Name" => 55,
  #                "Another Coach" => 34}
  #   assert_instance_of Hash, @seasonstats.count_coach_results("20122013", "WIN")
  #   @seasonstats.stubs(:count_coach_results).returns(expected)
  #   assert_equal expected, @seasonstats.count_coach_results("12345", "WIN")
  # end
  #
  # def test_winningest_coach
  #   assert_instance_of String, @seasonstats.winningest_coach("20122013")
  #   @seasonstats.stubs(:winningest_coach).returns("Claude Julien")
  #   assert_equal "Claude Julien", @seasonstats.winningest_coach("20122013")
  # end

end
