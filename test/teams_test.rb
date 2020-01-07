require 'minitest/autorun'
require 'minitest/pride'
require './lib/season'


class TeamTest < Minitest::Test

  def setup
    Team.from_csv('./data/teams.csv')
    @team = Team.all[0]
  end

  def test_it_can_return_team_info
    assert_equal "dfgdg", Team.team_info("18")
  end

end
