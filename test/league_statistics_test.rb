require "./test/test_helper"


class LeagueStatisticsTest < Minitest::Test
  def setup
    @data = { games: './data/games.csv',
              teams: './data/teams.csv',
              game_teams: './data/game_teams.csv'
            }
    @league_stats = LeagueStatistics.new(@data)
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_stats
  end

  def test_count_of_teams
    assert_equal 32, @league_stats.count_of_teams
  end
end
