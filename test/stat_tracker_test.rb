require "./test/test_helper.rb"
require './lib/team.rb'
require './lib/game_teams.rb'
require './lib/games.rb'

class StatTrackerTest < MiniTest::Test

  def setup
    StatTracker.remove_all
    @team = StatTracker.from_csv(Team, './data/teams.csv')
    @game_teams = StatTracker.from_csv(GameTeams, './data/game_teams.csv')
    @games = StatTracker.from_csv(Games, './data/games.csv')
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

  def test_it_can_get_highest_scoring_vistor_team
    assert_equal "FC Dallas", StatTracker.highest_visitor_team
  end

  def test_it_can_get_highest_scoring_home_team
    assert_equal "Reign FC", StatTracker.highest_home_team
  end
end
