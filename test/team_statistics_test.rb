require_relative 'test_helper'

class TeamStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'

    @stat ||= StatTracker.new({games: game_path, teams: team_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat
  end

  def test_team_info
    expected = {    "team_id" => "18",
                    "franchise_id" => "34",
                    "team_name" => "Minnesota United FC",
                    "abbreviation" => "MIN",
                    "link" => "/api/v1/teams/18"
                  }
    assert_equal expected, @stat.team_info("18")
    @stat.collect_seasons("1")
  end


end
