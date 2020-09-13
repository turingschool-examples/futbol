require './test/test_helper'
require './lib/team_manager'

class TeamManagerTest < Minitest::Test
  def test_it_can_generate_team_objects
    stat_tracker = mock('A totally legit stat_tracker')
    team_manager = TeamManager.new('./fixtures/teams_init_test.csv', stat_tracker)
    counter = 1

    team_manager.teams.each do |team|
      assert_instance_of Team, team
      assert_equal "t#{counter}", team.team_id
      assert_equal "f#{counter}", team.franchise_id
      assert_equal "n#{counter}", team.team_name
      assert_equal "a#{counter}", team.abbreviation
      assert_equal "s#{counter}", team.stadium
      assert_equal "l#{counter}", team.link
      counter += 1
    end
  end

  def test_it_has_attributes
    stat_tracker = mock('A totally legit stat_tracker')
    CSV.stubs(:foreach).returns(nil)  # This causes generate_teams to return []
    team_manager = TeamManager.new('A totally legit path', stat_tracker)

    assert_equal stat_tracker, team_manager.stat_tracker
    assert_equal [], team_manager.teams
  end

  def test_it_can_find_a_team_and_get_its_info
    team1 = mock('team 1')
    team1.stubs(:team_id).returns('1')
    team1.stubs(:team_info).returns('team1 info hash')
    team2 = mock('team 2')
    team2.stubs(:team_id).returns('2')
    team2.stubs(:team_info).returns('team2 info hash')
    team3 = mock('team 3')
    team3.stubs(:team_id).returns('3')
    team3.stubs(:team_info).returns('team3 info hash')
    stat_tracker = mock('A totally legit stat_tracker')
    team_array = [team1, team2, team3]
    CSV.stubs(:foreach).returns(nil)
    team_manager = TeamManager.new('A totally legit path', stat_tracker)
    team_manager.stubs(:teams).returns(team_array)

    assert_equal team1.team_info, team_manager.team_info('1')
    assert_equal team2.team_info, team_manager.team_info('2')
    assert_equal team3.team_info, team_manager.team_info('3')
  end

  def test_it_can_fetch_game_ids_for_a_team
    stat_tracker = mock('A totally legit stat_tracker')
    stat_tracker.stubs(:games_by_team).returns('An array of game ids')
    CSV.stubs(:foreach).returns(nil)
    team_manager = TeamManager.new('A totally legit path', stat_tracker)

    assert_equal 'An array of game ids', team_manager.game_ids_by_team('1')
  end

  def test_it_can_fetch_game_team_info
    stat_tracker = mock('A totally legit stat_tracker')
    stat_tracker.stubs(:game_team_info).returns('A hash of game teams')
    CSV.stubs(:foreach).returns(nil)
    team_manager = TeamManager.new('A totally legit path', stat_tracker)

    assert_equal 'A hash of game teams', team_manager.game_team_info('123')
  end

  def test_it_can_fetch_game_info
    stat_tracker = mock('A totally legit stat_tracker')
    stat_tracker.stubs(:game_info).returns('A hash of game info')
    CSV.stubs(:foreach).returns(nil)
    team_manager = TeamManager.new('A totally legit path', stat_tracker)

    assert_equal 'A hash of game info', team_manager.game_info('123')
  end

  def test_it_can_gather_all_game_team_info_for_a_team_id  # This is possibly a shitty test
    stat_tracker = mock('A totally legit stat_tracker')
    CSV.stubs(:foreach).returns(nil)
    team_manager = TeamManager.new('A totally legit path', stat_tracker)
    team_manager.stubs(:game_team_info).returns('A hash of game info')
    game_ids = ['2323232', '2323233']
    team_manager.stubs(:game_ids_by_team).returns(game_ids)
    expected = ['A hash of game info', 'A hash of game info']

    assert_equal expected, team_manager.gather_game_team_info('1')
  end

  # def test_it_can_find_most_goals_scored_by_team
  #   stat_tracker = mock('A totally legit stat_tracker')
  #   stat_tracker.stubs().returns()
  #   CSV.stubs(:foreach).returns(nil)
  #   team_manager = TeamManager.new('A totally legit path', stat_tracker)
  #
  # end
end
