require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_statistics'
require './lib/object_data'
require './lib/stat_tracker'
require './lib/season_statistics'

class SeasonStatisticsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @object_data ||= ObjectData.new(@stat_tracker)
    @season_statistics = SeasonStatistics.new
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_winningest_coach
   assert_equal "Claude Julien", @season_statistics.winningest_coach("20132014", @object_data.games, @object_data.game_teams)
   assert_equal "Alain Vigneault", @season_statistics.winningest_coach("20142015", @object_data.games, @object_data.game_teams)
  end

    def test_worst_coach
      assert_equal "Peter Laviolette" ,@season_statistics.worst_coach("20132014", @object_data.games, @object_data.game_teams)
      expected = ["Ted Nolan", "Craig MacTavish"]
      assert expected.include?(@season_statistics.worst_coach("20142015", @object_data.games, @object_data.game_teams))
    end

end
