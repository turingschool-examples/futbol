require "./test/test_helper.rb"
class StatTrackerTest < MiniTest::Test

  def test_it_exists
    stattracker1 = StatTracker.new
    assert_instance_of StatTracker, stattracker1
  end

  

end
