require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"

class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(file_path_locations)
  end

  # def test_it_exists_with_attributes
  #   assert_instance_of StatTracker, @stat_tracker
  #   assert_equal './data/games.csv', @stat_tracker.games
  #   assert_equal './data/teams.csv', @stat_tracker.teams
  #   assert_equal './data/game_teams.csv', @stat_tracker.game_teams
  # end

  # League Statistics count_of_teams method
  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_convert_team_id_to_name
    assert_equal "FC Dallas", @stat_tracker.team_name("6")
  end

  def test_scores
    assert_equal Hash, @stat_tracker.scores("away")
    assert_equal 32, @stat_tracker.scores("away").count
    assert_equal true, @stat_tracker.scores("away").all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

end
