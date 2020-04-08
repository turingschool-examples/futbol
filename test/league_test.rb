require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/league'
require './lib/game'
require './lib/team'
require './lib/game_stats'

class LeagueTest < Minitest::Test
  def test_it_exists
    league = League.new
    assert_instance_of League, league
  end

  def test_count_of_teams
    league = League.new
    Team.from_csv("./data/teams.csv")
    assert_equal 32, league.count_of_teams
  end

  def test_best_offense
    league = League.new
    GameStats.from_csv("./test/fixtures/game_teams_truncated.csv")
    assert_equal 0, league.best_offense
  end

end
