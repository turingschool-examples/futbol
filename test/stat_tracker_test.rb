require "./test/test_helper.rb"
require './lib/team.rb'
class StatTrackerTest < MiniTest::Test

  def setup
    @team = StatTracker.from_csv(Team, './data/teams.csv')
  end
end
