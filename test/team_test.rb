require "./test/test_helper.rb"
class Teamtest < MiniTest::Test

  def test_it_exists
    team = Team.new(info)

    assert_instance_of Team, team

  end


end
