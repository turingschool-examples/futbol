require_relative 'test_helper'

class SeasonStatistcsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat = StatTracker.new(@locations)

  end
#
  def test_it_exists

    @stat.coaches_per_season(@stat.find_all_seasons)
    # require "pry"; binding.pry

  end
#
#   def test_map_season_to_game_ids
#     season_statistics = SeasonStatistics.new(@stat)
#
#     assert_equal 7441, season_statistics.map_season_to_game_ids.count
#   end
#
#   def test_find_all_seasons
#     season_statistics = SeasonStatistics.new(@stat)
#
#     assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], season_statistics.find_all_seasons
#   end
#
#   def test_coach_game_results
#     season_statistics = SeasonStatistics.new(@stat)
#
#     assert_equal 6, season_statistics.coach_game_results.count
#   end
#
  def test_winningest_coach

    assert_equal "Claude Julien", @stat.winningest_coach("20132014")
    # assert_equal "Alain Vigneault", @stat.winningest_coach("20142015")
  end
#
#   def test_worst_coach
#     season_statistics = SeasonStatistics.new(@stat)
#
#     assert_equal "Peter Laviolette", season_statistics.worst_coach("20132014")
#     assert_equal "Craig MacTavish", season_statistics.worst_coach("20142015")
#   end
#
#   def test_most_accurate_team
#     season_statistics = SeasonStatistics.new(@stat)
#
#     assert_equal "Real Salt Lake", season_statistics.get_team_name_from_game_id
#
#     assert_equal "Real Salt Lake", season_statistics.most_accurate_team("20132014")
#     assert_equal "Toronto FC", season_statistics.most_accurate_team("20142015")
#   end

end
