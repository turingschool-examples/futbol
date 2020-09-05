require_relative 'test_helper'

class GameTest < Minitest::Test

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
    stat_tracker = StatTracker.new(@locations)
    game = Game.new(stat_tracker.games)

    assert_instance_of Game, game
  end

  def test_it_has_attributes
    stat_tracker = StatTracker.new(@locations)
    actual = stat_tracker.games["2012030221"]

    assert_equal 2012030221, actual.game_id
    assert_equal "20122013", actual.season
    assert_equal "Postseason", actual.type
    assert_equal "5/16/13", actual.date_time
    assert_equal 3, actual.away_team_id
    assert_equal 6, actual.home_team_id
    assert_equal 2, actual.away_goals
    assert_equal 3, actual.home_goals
    assert_equal "Toyota Stadium", actual.venue
    assert_equal "/api/v1/venues/null", actual.venue_link
  end

end
