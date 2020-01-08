require 'minitest/autorun'
require 'minitest/pride'
require './lib/season'


class TeamTest < Minitest::Test

  def setup
    Team.from_csv('./data/teams.csv')
    @team = Team.all[0]
  end

  def test_it_can_return_team_info
    assert_equal ({"team_id"=>"18", "franchise_id"=>"34",
      "team_name"=>"Minnesota United FC", "abbreviation"=>"MIN",
      "link"=>"/api/v1/teams/18"}), Team.team_info("18")
  end

end
