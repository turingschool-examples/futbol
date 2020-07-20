require "./test/test_helper.rb"
require './lib/team.rb'
require './lib/game_teams.rb'

class StatTrackerTest < MiniTest::Test

  def setup
    StatTracker.remove_all
    @team = StatTracker.from_csv(Team, './data/teams.csv')
    @game_teams = StatTracker.from_csv(GameTeams, './data/game_teams.csv')
  end

  def test_it_can_count_number_of_teams
    assert_equal 32, StatTracker.count_of_teams
  end

  def test_it_can_get_the_best_offense_team
   assert_equal "Reign FC", StatTracker.best_offense
  end

  def test_it_can_get_the_worst_team
   assert_equal "Utah Royals FC", StatTracker.worst_offense
  end
end
