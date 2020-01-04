require 'minitest/autorun'
require 'minitest/pride'
require './lib/league'

class LeagueTest < Minitest::Test

  def setup
    League.from_csv('./data/game_teams_dummy.csv')
    @league = League.all[0]
  end

  def test_it_exists
    assert_instance_of League, @league
  end

  # def test_count_of_teams
  #   assert_equal 23, League.count_of_teams
  # end

  # def test_best_offense
  #   assert_equal , League.best_offense
  # end
end
