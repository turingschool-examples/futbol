require "./test/test_helper"
require './lib/stat_tracker'
require './lib/team_manager'
require './lib/team'
require 'pry';
require 'mocha/minitest'

class TeamManagerTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    @team_manager = TeamsManager.new(team_path, stat_tracker)
  end

  def test_it_can_count_teams
    assert_equal 3, @team_manager.count_of_teams
  end

  def test_it_can_find_a_name
    team_number = '3'
    assert_equal 'Houston Dynamo', @team_manager.find_team_name(team_number)
  end

  def test_average_number_of_goals_scored_by_team
    assert_equal 1.5, @team_manager.average_number_of_goals_scored_by_team('3')
  end

  def test_find_best_offense
    assert_equal 'FC Dallas', @team_manager.best_offense
  end

  def test_find_worst_offense
    assert_equal 'Sporting Kansas City', @team_manager.worst_offense
  end

  def test_average_number_of_goals_scored_by_team_by_type
    assert_equal 1.67, @team_manager.average_number_of_goals_scored_by_team_by_type('3', 'away')
    assert_equal 1.33, @team_manager.average_number_of_goals_scored_by_team_by_type('3', 'home')
  end

  def test_it_can_find_highest_scoring_visitor
    assert_equal 'Sporting Kansas City', @team_manager.highest_scoring_visitor
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal 'Houston Dynamo', @team_manager.lowest_scoring_visitor
  end

  def test_it_can_find_highest_scoring_home
    assert_equal 'FC Dallas', @team_manager.highest_scoring_home
  end

  def test_it_can_lowest_scoring_home
    assert_equal 'Sporting Kansas City', @team_manager.lowest_scoring_home
  end

  def test_finding_a_team
    team_id = mock('5')
    @team_manager.stubs(:find_a_team).returns('team_5_object')
    assert_equal 'team_5_object', @team_manager.find_a_team(team_id)
  end

  def test_it_can_get_team_info
    team_id = '5'
    expected = {
                'team_id' => '5',
                'franchise_id' => '17',
                'team_name' => 'Sporting Kansas City',
                'abbreviation' => 'SKC',
                'link' => '/api/v1/teams/5'
    }
    assert_equal expected, @team_manager.team_info(team_id)
  end
end
