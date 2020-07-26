require "./test/test_helper"


class GameTest < Minitest::Test

  def setup
    row = {
      :game_id => "2014030412",
      :season => "20142015",
      :type => "Postseason",
      :date_time => "6/6/15",
      :away_team_id => "16",
      :home_team_id => "14",
      :away_goals => 3,
      :home_goals => 2,
      :venue => "Audi Field",
      :venue_link => "/api/v1/venues/null"
      }

      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
        stat_tracker = StatTracker.new(locations)
        stat_tracker.games
        @games = Games.new(row)
  end

  def test_it_exists

    assert_instance_of Games, @games
  end

  def test_it_has_attributes

      assert_equal "2014030412", @games.game_id
      assert_equal "20142015", @games.season
      assert_equal "Postseason", @games.type
      assert_equal "6/6/15", @games.date_time
      assert_equal "16", @games.away_team_id
      assert_equal "14", @games.home_team_id
      assert_equal 3, @games.away_goals
      assert_equal 2, @games.home_goals
      assert_equal "Audi Field", @games.venue
      assert_equal "/api/v1/venues/null", @games.venue_link
    end
  end
