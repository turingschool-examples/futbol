require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team= Team.new({team_id: 4, franchise_id: 18, team_name: "Barcelona", abbreviation: "BAC", link:1})
  end

  def test_it_exists
    assert_equal ({team_id: 4, franchise_id: 18, team_name: "Barcelona", abbreviation: "BAC", link: 1}),
     @team.team_info
  end
end
