require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @row = ["1", "23", "Atlanta United", "ATL", "Mercedes-Benz Stadium", "/api/v1/teams/1"]
  end
end
