require 'minitest/autorun'
require 'minitest/pride'
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
    assert_equal 1.75, @team_manager.average_number_of_goals_scored_by_team('3')
  end

  def test_find_best_offense
    assert_equal 'FC Dallas', @team_manager.best_offense
  end
end
