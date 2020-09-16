require_relative 'test_helper'

class StatsTest < Minitest::Test

  def test_it_exits_with_attributes
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'


    stats = Stats.new(game_path, team_path, game_teams_path)
    assert_instance_of Stats, stats
    assert_equal 2012030221, stats.game_stats_data.first.game_id
    assert_equal "John Tortorella", stats.game_teams_stats_data.first.head_coach
    assert_equal "Atlanta United", stats.teams_stats_data.first.teamname
  end

end
