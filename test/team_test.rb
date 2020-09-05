require_relative 'test_helper'

class TeamTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)
    team = Team.new(stat_tracker.teams)

    assert_instance_of Team, team
  end

  def test_it_has_attributes
    stat_tracker = StatTracker.new
    assert_equal false, stat_tracker.teams.include?("14")
    stat_tracker = StatTracker.from_csv(@locations)
    actual = stat_tracker.teams["14"]

    assert_equal "Audi Field", actual.stadium
    assert_equal "DC", actual.abbreviation
    assert_equal "31", actual.franchiseId
    assert_equal "/api/v1/teams/14", actual.link
    assert_equal "DC United", actual.team_name
    assert_equal 14, actual.team_id
  end
end
