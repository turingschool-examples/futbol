require "./test/test_helper"
require './lib/stat_tracker'
require './lib/team_manager'
require './lib/team'
require 'pry';
require 'mocha/minitest'

class TeamTest < Minitest::Test
  def setup
    data = {
            'team_id'      => '6',
            'franchiseId'  => '6',
            'teamName'     => 'FC Dallas',
            'abbreviation' => 'DAL',
            'Stadium'      => 'Toyota Stadium',
            'link'         => '/api/v1/teams/6'
            }
    game_path = './data/dummy_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    manager = TeamsManager.new(team_path, stat_tracker)
    @team = Team.new(data, manager)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_can_find_average_goals
    assert_equal 2.86, @team.average_goals
  end

  def test_it_can_find_average_goals_by_type
    assert_equal 2.75, @team.avg_goals_visitor
    assert_equal 3.00, @team.avg_goals_home
  end
end
